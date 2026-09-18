import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/models/chat_message.dart';
import 'chat_api.dart';
import '../models/chat_api_models.dart';

part 'chat_remote_data_source.g.dart';

abstract interface class ChatRemoteDataSource {
  Future<String> completeChat({
    required String model,
    required List<ChatMessage> messages,
  });
}

@riverpod
ChatRemoteDataSource chatRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return ChatRemoteDataSourceImpl(client: client, api: ChatApi(client.dio));
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl({required this.client, required this.api});

  final ApiClient client;
  final ChatApi api;

  @override
  Future<String> completeChat({
    required String model,
    required List<ChatMessage> messages,
  }) async {
    final response = await client.execute(
      () => api.completeChat(
        ChatCompletionRequest(
          model: model,
          messages: messages
              .map(
                (message) => ChatMessagePayload(
                  role: message.role == MessageRole.user ? 'user' : 'assistant',
                  content: message.content,
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
    final content = response.choices.firstOrNull?.message?.content;
    if (content is String && content.trim().isNotEmpty) {
      return content.trim();
    }
    if (content is List) {
      final combined = content
          .whereType<Map>()
          .map((part) => part['text'])
          .whereType<String>()
          .join()
          .trim();
      if (combined.isNotEmpty) return combined;
    }
    throw const ApiException(message: '接口返回成功，但回复内容为空。');
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
