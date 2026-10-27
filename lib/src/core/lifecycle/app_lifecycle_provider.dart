import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lifecycle_provider.g.dart';

/// 描述应用当前生命周期和最近一次内存压力事件。
///
/// 这个快照只表达资源管理所需的状态，不把导航、弹窗等 UI 行为带入
/// core 层。业务 ViewModel 可以据此暂停轮询，媒体组件可以据此释放原生资源。
class AppLifecycleSnapshot {
  /// 创建生命周期快照。
  const AppLifecycleSnapshot({
    this.state = AppLifecycleState.detached,
    this.memoryPressureRevision = 0,
  });

  /// Flutter 最近通知的生命周期状态。
  final AppLifecycleState state;

  /// 每次收到低内存通知都会递增，用于让资源持有者消费一次性事件。
  final int memoryPressureRevision;

  /// 当前是否已经回到前台可交互状态。
  bool get isResumed => state == AppLifecycleState.resumed;

  /// 当前是否应该暂停需要持续运行的资源。
  ///
  /// `inactive` 也需要暂停，因为移动端接听电话、拉起系统面板等场景
  /// 可能暂时没有进入 `paused`，但继续播放或轮询同样没有收益。
  bool get shouldSuspendResources => !isResumed;

  /// 当前是否处于明确的后台状态。
  bool get isBackgrounded => switch (state) {
    AppLifecycleState.hidden ||
    AppLifecycleState.paused ||
    AppLifecycleState.detached => true,
    _ => false,
  };

  /// 创建一个只替换指定字段的新快照。
  AppLifecycleSnapshot copyWith({
    AppLifecycleState? state,
    int? memoryPressureRevision,
  }) {
    return AppLifecycleSnapshot(
      state: state ?? this.state,
      memoryPressureRevision:
          memoryPressureRevision ?? this.memoryPressureRevision,
    );
  }
}

/// 监听应用生命周期并广播资源管理事件。
///
/// 该 Provider 保持存活，由应用根节点实例化一次。它只维护生命周期
/// 状态，不关闭数据库；SQLite 连接由应用进程级的 [AppDatabase] 负责持有。
@Riverpod(keepAlive: true)
class AppLifecycleNotifier extends _$AppLifecycleNotifier
    with WidgetsBindingObserver {
  @override
  AppLifecycleSnapshot build() {
    // ViewModel 单测可能只创建 ProviderContainer，没有启动 Flutter
    // binding；此时仍返回默认快照，让业务逻辑保持可测试，正式应用则由
    // runApp/ensureInitialized 提供真实的生命周期回调。
    WidgetsBinding? binding;
    try {
      binding = WidgetsBinding.instance;
    } on FlutterError {
      binding = null;
    }
    binding?.addObserver(this);
    ref.onDispose(() => binding?.removeObserver(this));
    return AppLifecycleSnapshot(
      state: binding?.lifecycleState ?? AppLifecycleState.detached,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (this.state.state == state) return;
    this.state = this.state.copyWith(state: state);
  }

  @override
  void didHaveMemoryPressure() {
    // 低内存时只释放 Flutter 图片缓存的活跃引用；磁盘缓存和 SQLite
    // 历史必须保留，否则用户会看到历史记录或媒体文件被意外清空。
    try {
      PaintingBinding.instance.imageCache.clearLiveImages();
    } on FlutterError {
      // 没有 Flutter binding 的纯 Dart 单测只验证事件计数，不需要清缓存。
    }
    state = state.copyWith(
      memoryPressureRevision: state.memoryPressureRevision + 1,
    );
  }
}
