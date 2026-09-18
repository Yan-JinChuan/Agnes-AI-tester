import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/core/utils/error_message.dart';
import 'package:agnes_ai_tester/src/features/settings/domain/models/model_info.dart';

import '../../../../core/config/app_config_provider.dart';
import '../../data/di/settings_data_providers.dart';

part 'model_catalog_view_model.freezed.dart';
part 'model_catalog_view_model.g.dart';

@freezed
class const ModelCatalogState({
  final List<ModelInfo> models = const [],
  final bool isLoading = false,
  final String? error,
}) with _$ModelCatalogState;

@riverpod
class ModelCatalogViewModel extends _$ModelCatalogViewModel {
  @override
  ModelCatalogState build() {
    // Recreate the state when the API key or Base URL changes, while keeping
    // the actual request behind the explicit “获取模型列表” action.
    ref.watch(appConfigProvider);
    return const ModelCatalogState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final models = await ref.read(settingsRepositoryProvider).fetchModels();
      state = state.copyWith(models: models, isLoading: false);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }
}
