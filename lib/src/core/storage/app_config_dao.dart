import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:agnes_ai_tester/src/core/config/app_config.dart';

import 'app_database.dart';

part 'app_config_dao.g.dart';

class AppConfigDao {
  final Database _db;

  AppConfigDao(this._db);

  /// 纯粹的 SQL 读操作
  Future<AppConfig?> readConfig() async {
    final records = await _db.query(DataBaseTableNames.settings);
    if (records.isEmpty) return null;

    final json = {
      for (final row in records)
        row['key'] as String: row['value'] as String? ?? '',
    };
    return AppConfig.fromJson(json);
  }

  /// 纯粹的 SQL 写操作
  Future<void> writeConfig(AppConfig config) async {
    await _db.transaction((transaction) async {
      for (final entry in config.toJson().entries) {
        await transaction.insert(DataBaseTableNames.settings, {
          'key': entry.key,
          'value': entry.value,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}

@Riverpod(keepAlive: true)
AppConfigDao appConfigDao(Ref ref) {
  return AppConfigDao(ref.watch(appDatabaseProvider).database);
}
