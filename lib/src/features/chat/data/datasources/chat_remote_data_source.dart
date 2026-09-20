import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import 'chat_api.dart';
import '../models/chat_api_models.dart';

part 'chat_remote_data_source.g.dart';

abstract interface class ChatRemoteDataSource {
  Future<ChatCompletionResponse> completeChat({
    required ChatCompletionRequest request,
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
  Future<ChatCompletionResponse> completeChat({
    required ChatCompletionRequest request,
  }) {
    return client.execute(() => api.completeChat(request));
  }
}
