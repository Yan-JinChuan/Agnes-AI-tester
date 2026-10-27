import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/core/cache/cache_usage.dart';
import 'package:agnes_ai_tester/src/core/cache/media_cache_repository.dart';
import 'package:agnes_ai_tester/src/core/cache/media_cache_repository_provider.dart';
import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/config/app_config_provider.dart';
import 'package:agnes_ai_tester/src/app.dart';
import 'package:agnes_ai_tester/src/features/chat/data/di/chat_data_providers.dart';
import 'package:agnes_ai_tester/src/features/chat/domain/models/chat_message.dart';
import 'package:agnes_ai_tester/src/features/chat/domain/models/conversation_summary.dart';
import 'package:agnes_ai_tester/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:agnes_ai_tester/src/features/generation/data/di/generation_data_providers.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/image_generation_record.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_options.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_record.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/repositories/image_repository.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/repositories/video_repository.dart';
import 'package:agnes_ai_tester/src/features/settings/presentation/views/connection_settings_dialog.dart';

void main() {
  testWidgets('renders the routed Agnes tester shell', (
    WidgetTester tester,
  ) async {
    await _pumpAgnesApp(tester);

    expect(find.text('Agnes AI 测试台'), findsOneWidget);
    expect(find.text('文本聊天'), findsNWidgets(2));
    expect(find.text('准备开始测试'), findsOneWidget);
    expect(find.byTooltip('连接设置'), findsOneWidget);
  });

  testWidgets('go_router navigates between generation modules', (
    WidgetTester tester,
  ) async {
    await _pumpAgnesApp(tester);

    await tester.tap(find.text('图片生成'));
    await tester.pumpAndSettle();
    expect(find.text('图片提示词'), findsOneWidget);

    await tester.tap(find.text('视频生成').first);
    await tester.pumpAndSettle();
    expect(find.text('视频提示词'), findsOneWidget);
  });

  testWidgets('connection settings are editable', (WidgetTester tester) async {
    await _pumpAgnesApp(
      tester,
      cacheRepository: _FakeMediaCacheRepository(usage: CacheUsage.empty),
    );

    await tester.tap(find.byTooltip('连接设置'));
    await tester.pumpAndSettle();
    expect(find.text('保存设置'), findsOneWidget);
    expect(find.text('图片模型'), findsOneWidget);
    expect(find.text('视频模型'), findsOneWidget);
  });

  testWidgets('settings can display and clear cache usage', (
    WidgetTester tester,
  ) async {
    final repository = _FakeMediaCacheRepository(
      usage: const CacheUsage(imageBytes: 1024, videoBytes: 2048),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(const AppConfig()),
          mediaCacheRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => const ConnectionSettingsDialog(),
                ),
                child: const Text('open settings'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open settings'));
    await tester.pumpAndSettle();
    expect(find.text('缓存管理'), findsOneWidget);
    expect(find.textContaining('FVP 视频'), findsNothing);
    expect(find.textContaining('总占用：3.0 KB'), findsOneWidget);

    await tester.tap(find.text('清除全部缓存'));
    await tester.pumpAndSettle();
    expect(find.text('确认清除'), findsOneWidget);

    await tester.tap(find.text('确认清除'));
    await tester.pumpAndSettle();

    expect(repository.clearCalled, isTrue);
    expect(find.textContaining('总占用：0 B'), findsOneWidget);
  });
}

Future<void> _pumpAgnesApp(
  WidgetTester tester, {
  MediaCacheRepository? cacheRepository,
}) async {
  final overrides = [
    chatRepositoryProvider.overrideWithValue(_FakeChatRepository()),
    imageRepositoryProvider.overrideWithValue(_FakeImageRepository()),
    videoRepositoryProvider.overrideWithValue(_FakeVideoRepository()),
    if (cacheRepository != null)
      mediaCacheRepositoryProvider.overrideWithValue(cacheRepository),
  ];
  await tester.pumpWidget(
    ProviderScope(overrides: overrides, child: const AgnesApp()),
  );
}

class _FakeChatRepository implements ChatRepository {
  @override
  Future<List<ChatMessage>> loadMessages(int conversationId) async => const [];

  @override
  Future<List<ConversationSummary>> loadConversations() async => const [];

  @override
  Future<int> createConversation(String firstPrompt) async => 1;

  @override
  Future<void> saveMessage(ChatMessage message, int conversationId) async {}

  @override
  Future<String> completeChat(List<ChatMessage> messages) async => '测试回复';
}

class _FakeImageRepository implements ImageRepository {
  @override
  Future<List<ImageGenerationRecord>> history() async => const [];

  @override
  Future<ImageGenerationRecord> generate({
    required String prompt,
    required String size,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required int id}) async {}
}

class _FakeVideoRepository implements VideoRepository {
  @override
  Future<List<VideoGenerationRecord>> history() async => const [];

  @override
  Future<VideoGenerationRecord> create({
    required String prompt,
    required VideoGenerationOptions options,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<VideoGenerationRecord> poll({required String videoId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String videoId}) async {}
}

class _FakeMediaCacheRepository implements MediaCacheRepository {
  _FakeMediaCacheRepository({required this.usage});

  CacheUsage usage;
  bool clearCalled = false;

  @override
  Future<void> clear() async {
    clearCalled = true;
    usage = CacheUsage.empty;
  }

  @override
  Future<CacheUsage> getUsage() async => usage;
}
