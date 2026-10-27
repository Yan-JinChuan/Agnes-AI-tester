import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/storage/app_database.dart';

part 'video_local_data_source.g.dart';

abstract interface class VideoLocalDataSource {
  Future<List<Map<String, Object?>>> loadHistory();

  Future<Map<String, Object?>?> findByVideoId(String videoId);

  Future<int> insertGeneration(Map<String, Object?> values);

  Future<void> updateGeneration({
    required String videoId,
    required Map<String, Object?> values,
  });

  /// Removes one video generation row from the local database.
  Future<void> deleteGeneration({required String videoId});
}

@riverpod
VideoLocalDataSource videoLocalDataSource(Ref ref) {
  return SqliteVideoLocalDataSource(
    database: ref.watch(appDatabaseProvider).database,
  );
}

class SqliteVideoLocalDataSource implements VideoLocalDataSource {
  const SqliteVideoLocalDataSource({required this.database});

  final Database database;

  @override
  Future<List<Map<String, Object?>>> loadHistory() async {
    return database.query(
      DataBaseTableNames.videoGenerations,
      orderBy: 'updated_at DESC, id DESC',
    );
  }

  @override
  Future<Map<String, Object?>?> findByVideoId(String videoId) async {
    final rows = await database.query(
      DataBaseTableNames.videoGenerations,
      where: 'video_id = ?',
      whereArgs: [videoId],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  @override
  Future<int> insertGeneration(Map<String, Object?> values) {
    return database.insert(DataBaseTableNames.videoGenerations, values);
  }

  @override
  Future<void> updateGeneration({
    required String videoId,
    required Map<String, Object?> values,
  }) async {
    await database.update(
      DataBaseTableNames.videoGenerations,
      values,
      where: 'video_id = ?',
      whereArgs: [videoId],
    );
  }

  @override
  Future<void> deleteGeneration({required String videoId}) async {
    await database.delete(
      DataBaseTableNames.videoGenerations,
      where: 'video_id = ?',
      whereArgs: [videoId],
    );
  }
}
