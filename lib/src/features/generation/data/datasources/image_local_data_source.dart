import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/storage/app_database.dart';

part 'image_local_data_source.g.dart';

abstract interface class ImageLocalDataSource {
  Future<List<Map<String, Object?>>> loadHistory();

  Future<int> insertGeneration(Map<String, Object?> values);

  /// Removes one image generation row from the local database.
  Future<void> deleteGeneration({required int id});
}

@riverpod
ImageLocalDataSource imageLocalDataSource(Ref ref) {
  return SqliteImageLocalDataSource(
    database: ref.watch(appDatabaseProvider).database,
  );
}

class SqliteImageLocalDataSource implements ImageLocalDataSource {
  const SqliteImageLocalDataSource({required this.database});

  final Database database;

  @override
  Future<List<Map<String, Object?>>> loadHistory() async {
    return database.query(
      DataBaseTableNames.imageGenerations,
      orderBy: 'created_at DESC, id DESC',
    );
  }

  @override
  Future<int> insertGeneration(Map<String, Object?> values) {
    return database.insert(DataBaseTableNames.imageGenerations, values);
  }

  @override
  Future<void> deleteGeneration({required int id}) async {
    await database.delete(
      DataBaseTableNames.imageGenerations,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
