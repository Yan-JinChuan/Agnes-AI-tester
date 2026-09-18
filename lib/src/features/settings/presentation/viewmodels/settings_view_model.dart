import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/app_config_provider.dart';
import '../../../../core/utils/error_message.dart';

part 'settings_view_model.freezed.dart';
part 'settings_view_model.g.dart';

@freezed
class const SettingsState({final bool isSaving = false, final String? error})
    with _$SettingsState;

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  @override
  SettingsState build() => const SettingsState();

  /// Applies temporary connection values so the model catalog can be queried.
  void previewConfig({required String apiKey, required String baseUrl}) {
    ref
        .read(appConfigProvider.notifier)
        .update(apiKey: apiKey, baseUrl: baseUrl);
  }

  Future<bool> saveConfig(AppConfig config) async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      await ref.read(appConfigProvider.notifier).setConfig(config);
      state = state.copyWith(isSaving: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isSaving: false,
        error: readableErrorMessage(error),
      );
      return false;
    }
  }

  void dismissError() => state = state.copyWith(error: null);
}
