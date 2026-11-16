import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_config_provider.dart';
import '../../core/storage/app_config_dao.dart';
import '../../core/storage/app_database.dart';

part 'app_startup_provider.g.dart';

/// 负责完成应用启动阶段必须串行完成的基础设施初始化。
///
/// 数据库连接必须先完成，配置才能从 SQLite 恢复；配置恢复只更新内存状态，
/// 避免首次启动时把读取动作再次写回数据库。
@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  await ref.watch(appDatabaseInitializationProvider.future);

  final persistedConfig = await ref.read(appConfigDaoProvider).readConfig();
  ref
      .read(appConfigProvider.notifier)
      .hydrate(persistedConfig ?? const AppConfig());
}
