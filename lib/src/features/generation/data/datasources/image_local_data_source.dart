import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';

part 'image_local_data_source.g.dart';

/// 声明图片生成历史的本地类型化存取契约。
abstract interface class ImageLocalDataSource {
  /// 按创建时间倒序读取图片生成历史。
  Future<List<ImageGenerationRow>> loadHistory();

  /// 插入一条类型化的图片生成记录并返回数据库行 id。
  Future<int> insertGeneration(ImageGenerationsCompanion values);

  /// 删除指定图片生成记录。
  Future<void> deleteGeneration({required int id});
}

/// 提供图片历史数据源，并复用应用唯一的 Drift 数据库。
@riverpod
ImageLocalDataSource imageLocalDataSource(Ref ref) {
  return DriftImageLocalDataSource(database: ref.watch(appDatabaseProvider));
}

/// 使用 Drift 实现图片历史存储契约。
class DriftImageLocalDataSource implements ImageLocalDataSource {
  /// 将图片历史操作绑定到应用共享的 Drift 连接。
  const DriftImageLocalDataSource({required this.database});

  final AppDatabase database;

  @override
  Future<List<ImageGenerationRow>> loadHistory() {
    return (database.select(database.imageGenerations)..orderBy([
          (generation) => OrderingTerm.desc(generation.createdAt),
          (generation) => OrderingTerm.desc(generation.id),
        ]))
        .get();
  }

  @override
  Future<int> insertGeneration(ImageGenerationsCompanion values) {
    return database.into(database.imageGenerations).insert(values);
  }

  @override
  Future<void> deleteGeneration({required int id}) async {
    await (database.delete(
      database.imageGenerations,
    )..where((generation) => generation.id.equals(id))).go();
  }
}
