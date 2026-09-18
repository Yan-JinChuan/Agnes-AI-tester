import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/chat_api_models.dart';

part 'chat_api.g.dart';

@RestApi()
abstract class ChatApi {
  factory ChatApi(Dio dio) = _ChatApi;

  @POST('chat/completions')
  Future<ChatCompletionResponse> completeChat(
    @Body() ChatCompletionRequest request,
  );
}
