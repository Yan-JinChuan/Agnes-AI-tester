import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/storage/app_config_dao.dart';

part 'app_config_provider.g.dart';

@Riverpod(keepAlive: true, name: "appConfigProvider")
class AppConfigNotifier extends _$AppConfigNotifier {
  AppConfigNotifier({this.initialConfig});

  final AppConfig? initialConfig;

  @override
  AppConfig build() => initialConfig ?? const AppConfig();

  /// 将启动阶段从 SQLite 恢复的配置写入内存状态，不重复写入数据库。
  void hydrate(AppConfig config) {
    state = config;
  }

  Future<void> setConfig(AppConfig newConfig) async {
    state = newConfig;
    final dao = ref.read(appConfigDaoProvider);
    await dao.writeConfig(newConfig);
  }

  void update({
    String? apiKey,
    String? baseUrl,
    String? textModel,
    String? imageModel,
    String? videoModel,
    String? cacheDirectory,
  }) async {
    final updated = state.copyWith(
      apiKey: apiKey ?? state.apiKey,
      baseUrl: baseUrl ?? state.baseUrl,
      textModel: textModel ?? state.textModel,
      imageModel: imageModel ?? state.imageModel,
      videoModel: videoModel ?? state.videoModel,
      cacheDirectory: cacheDirectory ?? state.cacheDirectory,
    );
    state = updated;
  }
}
