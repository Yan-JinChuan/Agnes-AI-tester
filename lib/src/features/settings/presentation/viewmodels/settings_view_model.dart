import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/app_config_provider.dart';
import '../../../../core/cache/cache_usage.dart';
import '../../../../core/cache/media_cache_repository_provider.dart';
import '../../../../core/utils/error_message.dart';

part 'settings_view_model.freezed.dart';
part 'settings_view_model.g.dart';

@freezed
/// 设置页保存状态与缓存管理状态。
class const SettingsState({
  final bool isSaving = false,
  final String? error,
  final CacheUsage? cacheUsage,
  final bool isLoadingCache = false,
  final bool isClearingCache = false,
}) with _$SettingsState;

@riverpod
/// 管理连接配置保存、模型预览和媒体缓存操作。
class SettingsViewModel extends _$SettingsViewModel {
  @override
  SettingsState build() => const SettingsState();

  /// 临时应用连接信息，以便设置页查询模型列表。
  void previewConfig({required String apiKey, required String baseUrl}) {
    ref
        .read(appConfigProvider.notifier)
        .update(apiKey: apiKey, baseUrl: baseUrl);
  }

  /// 保存连接、模型和缓存目录配置。
  ///
  /// 状态中的保存标记用于在 SQLite 写入期间禁用提交按钮。
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

  /// 为设置页的缓存管理区域加载最新占用快照。
  Future<void> loadCacheUsage() async {
    state = state.copyWith(isLoadingCache: true, error: null);
    try {
      final usage = await ref.read(mediaCacheRepositoryProvider).getUsage();
      state = state.copyWith(cacheUsage: usage, isLoadingCache: false);
    } catch (error) {
      state = state.copyWith(
        isLoadingCache: false,
        error: readableErrorMessage(error),
      );
    }
  }

  /// 清理所有媒体缓存，并刷新设置页显示的磁盘占用。
  Future<bool> clearCache() async {
    state = state.copyWith(isClearingCache: true, error: null);
    try {
      final repository = ref.read(mediaCacheRepositoryProvider);
      await repository.clear();
      final usage = await repository.getUsage();
      state = state.copyWith(cacheUsage: usage, isClearingCache: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isClearingCache: false,
        error: readableErrorMessage(error),
      );
      return false;
    }
  }

  /// 清除设置页已经展示过的一次性错误信息。
  void dismissError() => state = state.copyWith(error: null);
}
