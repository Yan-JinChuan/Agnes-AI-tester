import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/core/config/app_config.dart';

import 'app_database.dart';

part 'app_config_dao.g.dart';

/// 通过数据库设置表读取和持久化全局应用配置。
class AppConfigDao {
  /// 创建配置访问器并绑定到应用唯一的 Drift 数据库。
  AppConfigDao(this._db);

  final AppDatabase _db;

  /// 读取键值表并还原配置；没有持久化配置时返回 `null`。
  Future<AppConfig?> readConfig() async {
    final records = await _db.select(_db.appSettings).get();
    if (records.isEmpty) return null;

    final json = {for (final row in records) row.key: row.value};
    return AppConfig.fromJson(json);
  }

  /// 在单个事务中保存完整配置，避免失败时留下部分键值。
  Future<void> writeConfig(AppConfig config) async {
    await _db.transaction(() async {
      for (final entry in config.toJson().entries) {
        await _db
            .into(_db.appSettings)
            .insertOnConflictUpdate(
              AppSettingsCompanion.insert(key: entry.key, value: entry.value),
            );
      }
    });
  }
}

@Riverpod(keepAlive: true)
AppConfigDao appConfigDao(Ref ref) {
  return AppConfigDao(ref.watch(appDatabaseProvider));
}
