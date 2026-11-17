import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';

part 'video_local_data_source.g.dart';

/// 声明视频生成历史的本地类型化存取契约。
abstract interface class VideoLocalDataSource {
  /// 按最近更新时间倒序读取视频生成历史。
  Future<List<VideoGenerationRow>> loadHistory();

  /// 按 Agnes 视频 id 查找本地记录；不存在时返回 `null`。
  Future<VideoGenerationRow?> findByVideoId(String videoId);

  /// 插入一条类型化的视频生成记录并返回数据库行 id。
  Future<int> insertGeneration(VideoGenerationsCompanion values);

  /// 按视频 id 更新记录，并保留未提供的字段。
  Future<void> updateGeneration({
    required String videoId,
    required VideoGenerationsCompanion values,
  });

  /// 删除指定视频 id 对应的本地记录。
  Future<void> deleteGeneration({required String videoId});
}

/// 提供视频历史数据源，并复用应用唯一的 Drift 数据库。
@riverpod
VideoLocalDataSource videoLocalDataSource(Ref ref) {
  return DriftVideoLocalDataSource(database: ref.watch(appDatabaseProvider));
}

/// 使用 Drift 实现视频历史存储契约。
class DriftVideoLocalDataSource implements VideoLocalDataSource {
  /// 将视频历史操作绑定到应用共享的 Drift 连接。
  const DriftVideoLocalDataSource({required this.database});

  final AppDatabase database;

  @override
  Future<List<VideoGenerationRow>> loadHistory() {
    return (database.select(database.videoGenerations)..orderBy([
          (generation) => OrderingTerm.desc(generation.updatedAt),
          (generation) => OrderingTerm.desc(generation.id),
        ]))
        .get();
  }

  @override
  Future<VideoGenerationRow?> findByVideoId(String videoId) {
    return (database.select(database.videoGenerations)
          ..where((generation) => generation.videoId.equals(videoId))
          ..limit(1))
        .getSingleOrNull();
  }

  @override
  Future<int> insertGeneration(VideoGenerationsCompanion values) {
    return database.into(database.videoGenerations).insert(values);
  }

  @override
  Future<void> updateGeneration({
    required String videoId,
    required VideoGenerationsCompanion values,
  }) async {
    await (database.update(
      database.videoGenerations,
    )..where((generation) => generation.videoId.equals(videoId))).write(values);
  }

  @override
  Future<void> deleteGeneration({required String videoId}) async {
    await (database.delete(
      database.videoGenerations,
    )..where((generation) => generation.videoId.equals(videoId))).go();
  }
}
