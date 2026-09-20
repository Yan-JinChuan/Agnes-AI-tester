// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCompletionRequest _$ChatCompletionRequestFromJson(
  Map<String, dynamic> json,
) => ChatCompletionRequest(
  model: json['model'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessagePayload.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatCompletionRequestToJson(
  ChatCompletionRequest instance,
) => <String, dynamic>{
  'model': instance.model,
  'messages': instance.messages.map((e) => e.toJson()).toList(),
};

ChatMessagePayload _$ChatMessagePayloadFromJson(Map<String, dynamic> json) =>
    ChatMessagePayload(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChatMessagePayloadToJson(ChatMessagePayload instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

ChatCompletionResponse _$ChatCompletionResponseFromJson(
  Map<String, dynamic> json,
) => ChatCompletionResponse(
  choices:
      (json['choices'] as List<dynamic>?)
          ?.map((e) => ChatCompletionChoice.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

ChatCompletionChoice _$ChatCompletionChoiceFromJson(
  Map<String, dynamic> json,
) => ChatCompletionChoice(
  message: json['message'] == null
      ? null
      : ChatCompletionMessage.fromJson(json['message'] as Map<String, dynamic>),
);

ChatCompletionMessage _$ChatCompletionMessageFromJson(
  Map<String, dynamic> json,
) => ChatCompletionMessage(content: json['content']);
