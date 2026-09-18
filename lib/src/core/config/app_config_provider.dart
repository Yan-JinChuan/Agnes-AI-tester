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

  Future<void> setConfig(AppConfig newConfig) async {
    state = newConfig;
    final dao = await ref.read(appConfigDaoProvider.future);
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
