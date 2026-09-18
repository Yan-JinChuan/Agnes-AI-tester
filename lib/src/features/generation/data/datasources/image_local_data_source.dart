import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/app_database.dart';

part 'image_local_data_source.g.dart';

abstract interface class ImageLocalDataSource {
  Future<List<Map<String, Object?>>> loadHistory();

  Future<int> insertGeneration(Map<String, Object?> values);
}

@riverpod
ImageLocalDataSource imageLocalDataSource(Ref ref) {
  return SqliteImageLocalDataSource(database: ref.watch(appDatabaseProvider));
}

class SqliteImageLocalDataSource implements ImageLocalDataSource {
  const SqliteImageLocalDataSource({required this.database});

  final AppDatabase database;

  @override
  Future<List<Map<String, Object?>>> loadHistory() async {
    return (await database.database).query(
      DataBaseTableNames.imageGenerations,
      orderBy: 'created_at DESC, id DESC',
    );
  }

  @override
  Future<int> insertGeneration(Map<String, Object?> values) {
    return database.database.then(
      (db) => db.insert(DataBaseTableNames.imageGenerations, values),
    );
  }
}
