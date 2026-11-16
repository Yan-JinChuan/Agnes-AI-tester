// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_startup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 负责完成应用启动阶段必须串行完成的基础设施初始化。
///
/// 数据库连接必须先完成，配置才能从 SQLite 恢复；配置恢复只更新内存状态，
/// 避免首次启动时把读取动作再次写回数据库。

@ProviderFor(appStartup)
final appStartupProvider = AppStartupProvider._();

/// 负责完成应用启动阶段必须串行完成的基础设施初始化。
///
/// 数据库连接必须先完成，配置才能从 SQLite 恢复；配置恢复只更新内存状态，
/// 避免首次启动时把读取动作再次写回数据库。

final class AppStartupProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// 负责完成应用启动阶段必须串行完成的基础设施初始化。
  ///
  /// 数据库连接必须先完成，配置才能从 SQLite 恢复；配置恢复只更新内存状态，
  /// 避免首次启动时把读取动作再次写回数据库。
  AppStartupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStartupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStartupHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return appStartup(ref);
  }
}

String _$appStartupHash() => r'6bb7c4ad445b05781ba4dd3b67c63c06d34a3434';
