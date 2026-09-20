// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGenerationRequest _$ImageGenerationRequestFromJson(
  Map<String, dynamic> json,
) => ImageGenerationRequest(
  model: json['model'] as String,
  prompt: json['prompt'] as String,
  size: json['size'] as String,
  n: (json['n'] as num?)?.toInt() ?? 1,
  extraBody: json['extra_body'] as Map<String, dynamic>?,
);

ImageGenerationResponse _$ImageGenerationResponseFromJson(
  Map<String, dynamic> json,
) => ImageGenerationResponse(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
  url: json['url'] as String?,
  base64Json: json['b64_json'] as String?,
);
