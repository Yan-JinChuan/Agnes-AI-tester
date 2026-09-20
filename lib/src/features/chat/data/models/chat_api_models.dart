import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/chat_message.dart';

part 'chat_api_models.freezed.dart';
part 'chat_api_models.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ChatCompletionRequest({
  required final String model,
  required final List<ChatMessagePayload> messages,
}) with _$ChatCompletionRequest {
  factory ChatCompletionRequest.fromDomain({
    required String model,
    required List<ChatMessage> messages,
  }) {
    return ChatCompletionRequest(
      model: model,
      messages: messages
          .map(
            (message) => ChatMessagePayload(
              role: message.role == MessageRole.user ? 'user' : 'assistant',
              content: message.content,
            ),
          )
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() => _$ChatCompletionRequestToJson(this);

  factory ChatCompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionRequestFromJson(json);
}

@freezed
@JsonSerializable()
class ChatMessagePayload({
  required final String role,
  required final String content,
}) with _$ChatMessagePayload {
  factory ChatMessagePayload.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessagePayloadToJson(this);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ChatCompletionResponse({
  final List<ChatCompletionChoice> choices = const [],
}) with _$ChatCompletionResponse {
  String? get textContent {
    final content = choices.firstOrNull?.message?.content;
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
    return null;
  }

  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionResponseFromJson(json);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ChatCompletionChoice({final ChatCompletionMessage? message})
    with _$ChatCompletionChoice {
  factory ChatCompletionChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionChoiceFromJson(json);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ChatCompletionMessage({final Object? content})
    with _$ChatCompletionMessage {
  factory ChatCompletionMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionMessageFromJson(json);
}
