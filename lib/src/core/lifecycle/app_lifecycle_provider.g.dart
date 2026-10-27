// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lifecycle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 监听应用生命周期并广播资源管理事件。
///
/// 该 Provider 保持存活，由应用根节点实例化一次。它只维护生命周期
/// 状态，不关闭数据库；SQLite 连接由应用进程级的 [AppDatabase] 负责持有。

@ProviderFor(AppLifecycleNotifier)
final appLifecycleProvider = AppLifecycleNotifierProvider._();

/// 监听应用生命周期并广播资源管理事件。
///
/// 该 Provider 保持存活，由应用根节点实例化一次。它只维护生命周期
/// 状态，不关闭数据库；SQLite 连接由应用进程级的 [AppDatabase] 负责持有。
final class AppLifecycleNotifierProvider
    extends $NotifierProvider<AppLifecycleNotifier, AppLifecycleSnapshot> {
  /// 监听应用生命周期并广播资源管理事件。
  ///
  /// 该 Provider 保持存活，由应用根节点实例化一次。它只维护生命周期
  /// 状态，不关闭数据库；SQLite 连接由应用进程级的 [AppDatabase] 负责持有。
  AppLifecycleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLifecycleNotifierHash();

  @$internal
  @override
  AppLifecycleNotifier create() => AppLifecycleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLifecycleSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLifecycleSnapshot>(value),
    );
  }
}

String _$appLifecycleNotifierHash() =>
    r'c3477b1426bf97c90ceaa691d0f93aba7d7a0dff';

/// 监听应用生命周期并广播资源管理事件。
///
/// 该 Provider 保持存活，由应用根节点实例化一次。它只维护生命周期
/// 状态，不关闭数据库；SQLite 连接由应用进程级的 [AppDatabase] 负责持有。

abstract class _$AppLifecycleNotifier extends $Notifier<AppLifecycleSnapshot> {
  AppLifecycleSnapshot build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLifecycleSnapshot, AppLifecycleSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLifecycleSnapshot, AppLifecycleSnapshot>,
              AppLifecycleSnapshot,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
