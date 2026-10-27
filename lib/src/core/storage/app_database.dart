import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import 'database_factory.dart';

part 'app_database.g.dart';

abstract class DataBaseTableNames {
  static const String settings = "settings";
  static const String messages = "messages";
  static const String conversations = "conversations";
  static const String idxMessagesConversation = "idx_messages_conversation";
  static const String imageGenerations = "image_generations";
  static const String videoGenerations = "video_generations";
  static const String idxVideoGenerationsUpdated =
      "idx_video_generations_updated";
}

/// 提供应用级数据库依赖的注入入口。
///
/// 数据库必须由应用组合根（`main()`）完成异步打开后通过 override 注入，
/// 这样数据源在创建时拿到的就是可直接使用的连接，而不会把初始化等待
/// 泄漏到每一次 SQL 操作中。
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  throw StateError(
    'AppDatabase 尚未初始化，请在 ProviderScope 中覆盖 appDatabaseProvider。',
  );
}

class AppDatabase {
  AppDatabase._(this._database);

  final Database _database;

  /// 打开数据库并完成建表或迁移。
  ///
  /// `databasePath` 仅用于测试和特殊宿主环境；生产环境省略时使用应用文档目录。
  static Future<AppDatabase> open({
    String? databasePath,
    DatabaseFactory? factory,
  }) async {
    final resolvedPath = databasePath ?? await _databasePath();
    final database = await (factory ?? getDatabaseFactory()).openDatabase(
      resolvedPath,
      options: OpenDatabaseOptions(
        version: 3,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (db, version) async {
          await _createCoreTables(db);
          await _createGenerationTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await _createGenerationTables(db);
          } else if (oldVersion < 3) {
            await _upgradeVideoGenerationToV3(db);
          }
        },
      ),
    );
    return AppDatabase._(database);
  }

  /// 返回已经完成初始化的 SQLite 连接。
  Database get database => _database;

  static Future<String> _databasePath() async {
    if (kIsWeb) return 'agnes_ai_tester.db';
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, 'agnes_ai_tester.db');
  }

  /// 关闭数据库连接；重复调用不会产生副作用。
  Future<void> close() async {
    if (_database.isOpen) await _database.close();
  }

  static Future<void> _createCoreTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.conversations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.messages} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        conversation_id INTEGER NOT NULL,
        role TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (conversation_id) REFERENCES ${DataBaseTableNames.conversations} (id)
          ON DELETE CASCADE
      )
    ''');
    await db.execute(
      'CREATE INDEX ${DataBaseTableNames.idxMessagesConversation} '
      'ON ${DataBaseTableNames.messages} (conversation_id, created_at)',
    );
  }

  static Future<void> _createGenerationTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.settings} (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.imageGenerations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        prompt TEXT NOT NULL,
        model TEXT NOT NULL,
        size TEXT NOT NULL,
        url TEXT,
        image_bytes BLOB,
        created_at INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${DataBaseTableNames.videoGenerations} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        video_id TEXT NOT NULL UNIQUE,
        prompt TEXT NOT NULL,
        model TEXT NOT NULL,
        status TEXT NOT NULL,
        progress INTEGER NOT NULL DEFAULT 0,
        url TEXT,
        error TEXT,
        request_json TEXT NOT NULL DEFAULT '{}',
        actual_size TEXT,
        seconds REAL,
        metadata_message TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    await db.execute(
      'CREATE INDEX ${DataBaseTableNames.idxVideoGenerationsUpdated} '
      'ON ${DataBaseTableNames.videoGenerations} (updated_at DESC)',
    );
  }

  static Future<void> _upgradeVideoGenerationToV3(Database db) async {
    await db.execute(
      "ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN request_json TEXT NOT NULL DEFAULT '{}'",
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN actual_size TEXT',
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN seconds REAL',
    );
    await db.execute(
      'ALTER TABLE ${DataBaseTableNames.videoGenerations} ADD COLUMN metadata_message TEXT',
    );
  }
}
