import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/app.dart';

void main() {
  testWidgets('renders the routed Agnes tester shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AgnesApp()));

    expect(find.text('Agnes AI 测试台'), findsOneWidget);
    expect(find.text('文本聊天'), findsNWidgets(2));
    expect(find.text('准备开始测试'), findsOneWidget);
    expect(find.byTooltip('连接设置'), findsOneWidget);
  });

  testWidgets('go_router navigates between generation modules', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AgnesApp()));

    await tester.tap(find.text('图片生成'));
    await tester.pumpAndSettle();
    expect(find.text('图片提示词'), findsOneWidget);

    await tester.tap(find.text('视频生成').first);
    await tester.pumpAndSettle();
    expect(find.text('视频提示词'), findsOneWidget);
  });

  testWidgets('connection settings are editable', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AgnesApp()));

    await tester.tap(find.byTooltip('连接设置'));
    await tester.pumpAndSettle();
    expect(find.text('保存设置'), findsOneWidget);
    expect(find.text('图片模型'), findsOneWidget);
    expect(find.text('视频模型'), findsOneWidget);
  });
}
