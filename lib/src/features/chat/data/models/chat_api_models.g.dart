// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatCompletionRequest _$ChatCompletionRequestFromJson(
  Map<String, dynamic> json,
) => _ChatCompletionRequest(
  model: json['model'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessagePayload.fromJson(e as Map<String, dynamic>))
      .toList(),
);

_ChatMessagePayload _$ChatMessagePayloadFromJson(Map<String, dynamic> json) =>
    _ChatMessagePayload(
      role: json['role'] as String,
      content: json['content'] as String,
    );

_ChatCompletionResponse _$ChatCompletionResponseFromJson(
  Map<String, dynamic> json,
) => _ChatCompletionResponse(
  choices:
      (json['choices'] as List<dynamic>?)
          ?.map((e) => ChatCompletionChoice.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

_ChatCompletionChoice _$ChatCompletionChoiceFromJson(
  Map<String, dynamic> json,
) => _ChatCompletionChoice(
  message: json['message'] == null
      ? null
      : ChatCompletionMessage.fromJson(json['message'] as Map<String, dynamic>),
);

_ChatCompletionMessage _$ChatCompletionMessageFromJson(
  Map<String, dynamic> json,
) => _ChatCompletionMessage(content: json['content']);
