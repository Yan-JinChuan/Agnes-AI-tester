import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/lifecycle/app_lifecycle_provider.dart';
import 'router/app_router.dart';
import 'startup/app_startup_widget.dart';

/// 应用顶层组装入口，负责组合主题、路由和启动过渡态。
class MyApp extends ConsumerWidget {
  /// 创建应用根组件。
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 在应用根节点实例化一次生命周期监听，保证页面未打开时也能收到
    // 后台、恢复前台和低内存事件。具体资源由各自的消费者释放。
    ref.watch(appLifecycleProvider);
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF5D5FEF),
      brightness: Brightness.light,
    );
    return MaterialApp.router(
      title: 'Agnes AI 测试台',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) => AppStartupWidget(child: child),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        splashFactory: InkRipple.splashFactory,
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: scheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: scheme.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
