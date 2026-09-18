import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_api_models.freezed.dart';
part 'chat_api_models.g.dart';

@Freezed(toJson: false)
class ChatCompletionRequest({
  required final String model,
  required final List<ChatMessagePayload> messages,
}) with _$ChatCompletionRequest {
  Map<String, dynamic> toJson() => {
    'model': model,
    'messages': messages.map((message) => message.toJson()).toList(),
  };

  factory ChatCompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionRequestFromJson(json);
}

@Freezed(toJson: false)
class ChatMessagePayload({
  required final String role,
  required final String content,
}) with _$ChatMessagePayload {
  Map<String, dynamic> toJson() => {'role': role, 'content': content};

  factory ChatMessagePayload.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagePayloadFromJson(json);
}

@Freezed(toJson: false)
class ChatCompletionResponse({
  final List<ChatCompletionChoice> choices = const [],
}) with _$ChatCompletionResponse {
  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionResponseFromJson(json);
}

@Freezed(toJson: false)
class ChatCompletionChoice({final ChatCompletionMessage? message})
    with _$ChatCompletionChoice {
  factory ChatCompletionChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionChoiceFromJson(json);
}

@Freezed(toJson: false)
class ChatCompletionMessage({final Object? content})
    with _$ChatCompletionMessage {
  factory ChatCompletionMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionMessageFromJson(json);
}
