import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/app/startup/app_startup_provider.dart';
import 'package:agnes_ai_tester/src/app/startup/app_startup_widget.dart';

void main() {
  testWidgets('shows a loading state until startup completes', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>();

    await tester.pumpWidget(_TestApp(startup: (ref) => completer.future));

    expect(find.text('正在初始化应用…'), findsOneWidget);
    expect(find.text('ready'), findsNothing);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('ready'), findsOneWidget);
  });

  testWidgets('can retry after startup fails', (WidgetTester tester) async {
    var attempt = 0;

    await tester.pumpWidget(
      _TestApp(
        startup: (ref) async {
          if (attempt == 0) {
            throw StateError('启动失败');
          }
        },
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('应用启动失败'), findsOneWidget);
    expect(find.text('启动失败'), findsOneWidget);

    attempt = 1;
    await tester.tap(find.text('重试'));
    await tester.pumpAndSettle();

    expect(find.text('ready'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.startup});

  final Future<void> Function(Ref ref) startup;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [appStartupProvider.overrideWith(startup)],
      child: MaterialApp(
        builder: (context, child) => AppStartupWidget(child: child),
        home: const Text('ready'),
      ),
    );
  }
}
