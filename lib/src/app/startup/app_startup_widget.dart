import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/app_database.dart';
import 'app_startup_provider.dart';

/// 在路由内容外提供应用启动过渡态，并在启动失败时提供重试入口。
///
/// 该组件设计为放置在 [MaterialApp.router.builder] 中，因此不会创建第二个
/// `MaterialApp` 或 `ProviderScope`，同时可以直接复用应用主题与路由子树。
class AppStartupWidget extends ConsumerWidget {
  /// 创建应用启动过渡组件。
  const AppStartupWidget({required this.child, super.key});

  /// MaterialApp.router builder 传入的路由内容。
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(appStartupProvider);

    return switch (startup) {
      AsyncLoading<void>() => const _AppStartupLoadingView(),
      AsyncData<void>() => child ?? const SizedBox.shrink(),
      AsyncError<void>(:final error) => _AppStartupErrorView(
        error: error,
        onRetry: () {
          ref.invalidate(appDatabaseInitializationProvider);
          ref.invalidate(appStartupProvider);
        },
      ),
    };
  }
}

class _AppStartupLoadingView extends StatelessWidget {
  const _AppStartupLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在初始化应用…'),
          ],
        ),
      ),
    );
  }
}

class _AppStartupErrorView extends StatelessWidget {
  const _AppStartupErrorView({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('应用启动失败'),
              const SizedBox(height: 8),
              Text(_readableError(error), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('重试')),
            ],
          ),
        ),
      ),
    );
  }
}

String _readableError(Object error) {
  final message = error.toString();
  return message.startsWith('Bad state: ')
      ? message.substring('Bad state: '.length)
      : message;
}
