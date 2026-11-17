import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// 应用设置的键值表，数据库列名与现有 SQLite schema 保持一致。
@DataClassName('AppSettingRow')
class AppSettings extends Table {
  @override
  String get tableName => 'settings';

  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// 聊天会话持久化表。
@DataClassName('ConversationRow')
class Conversations extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  IntColumn get createdAt => integer()();

  IntColumn get updatedAt => integer()();
}

/// 聊天消息持久化表，删除会话时级联清理其消息。
@TableIndex(
  name: 'idx_messages_conversation',
  columns: {#conversationId, #createdAt},
)
@DataClassName('ChatMessageRow')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get conversationId =>
      integer().references(Conversations, #id, onDelete: KeyAction.cascade)();

  TextColumn get role => text()();

  TextColumn get content => text()();

  IntColumn get createdAt => integer()();
}

/// 图片生成历史表。
@DataClassName('ImageGenerationRow')
class ImageGenerations extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get prompt => text()();

  TextColumn get model => text()();

  TextColumn get size => text()();

  TextColumn get url => text().nullable()();

  BlobColumn get imageBytes => blob().nullable()();

  IntColumn get createdAt => integer()();
}

/// 视频生成历史表。
@TableIndex.sql(
  'CREATE INDEX idx_video_generations_updated '
  'ON video_generations (updated_at DESC)',
)
@DataClassName('VideoGenerationRow')
class VideoGenerations extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get videoId => text().unique()();

  TextColumn get prompt => text()();

  TextColumn get model => text()();

  TextColumn get status => text()();

  IntColumn get progress => integer().withDefault(const Constant(0))();

  TextColumn get url => text().nullable()();

  TextColumn get error => text().nullable()();

  TextColumn get requestJson => text().withDefault(const Constant('{}'))();

  TextColumn get actualSize => text().nullable()();

  RealColumn get seconds => real().nullable()();

  TextColumn get metadataMessage => text().nullable()();

  IntColumn get createdAt => integer()();

  IntColumn get updatedAt => integer()();
}

/// 异步打开并持有应用唯一的 Drift 数据库连接。
///
/// 启动编排通过 `.future` 等待 schema 初始化；业务数据源继续使用同步
/// [appDatabaseProvider]，避免在每次查询前等待数据库打开。
@DriftDatabase(
  tables: [
    AppSettings,
    Conversations,
    Messages,
    ImageGenerations,
    VideoGenerations,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// 使用传入的 executor 构造数据库；省略时打开平台默认持久化文件。
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // 1. v1 已有聊天表，只补入设置、图片和视频表。
        await migrator.createTable(appSettings);
        await migrator.createTable(imageGenerations);
        await migrator.createTable(videoGenerations);
      } else if (from < 3) {
        // 2. v2 视频记录补齐 v3 的请求参数与元信息列。
        await migrator.addColumn(
          videoGenerations,
          videoGenerations.requestJson,
        );
        await migrator.addColumn(videoGenerations, videoGenerations.actualSize);
        await migrator.addColumn(videoGenerations, videoGenerations.seconds);
        await migrator.addColumn(
          videoGenerations,
          videoGenerations.metadataMessage,
        );
      }
    },
    beforeOpen: (details) async {
      // 每次打开数据库时启用外键支持，cascade 才会真正生效
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// 打开数据库并等待首次连接及 schema 创建或升级完成。
  static Future<AppDatabase> open() async {
    final database = AppDatabase();
    await database.customSelect('SELECT 1').getSingle();
    return database;
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'agnes_ai_tester',
      native: DriftNativeOptions(
        databasePath: () async {
          final directory = await getApplicationDocumentsDirectory();
          return path.join(directory.path, 'agnes_ai_tester.db');
        },
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}

/// 异步初始化并在 Provider 生命周期结束时关闭唯一数据库连接。
@Riverpod(keepAlive: true)
Future<AppDatabase> appDatabaseInitialization(Ref ref) async {
  final database = await AppDatabase.open();
  ref.onDispose(() => database.close());
  return database;
}

/// 将已完成初始化的数据库连接同步提供给数据层。
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return ref.watch(appDatabaseInitializationProvider).requireValue;
}
