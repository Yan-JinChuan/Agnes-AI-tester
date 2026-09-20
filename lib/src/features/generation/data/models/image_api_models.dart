import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/image_generation_result.dart';

part 'image_api_models.freezed.dart';
part 'image_api_models.g.dart';

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ImageGenerationRequest({
  required final String model,
  required final String prompt,
  required final String size,
  final int n = 1,
  @JsonKey(name: 'extra_body') final Map<String, dynamic>? extraBody,
}) with _$ImageGenerationRequest {
  Map<String, dynamic> toJson() => {
    'model': model,
    'prompt': prompt,
    'size': size,
    'n': n,
    if (extraBody != null) 'extra_body': extraBody,
  };

  factory ImageGenerationRequest.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationRequestFromJson(json);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ImageGenerationResponse({final List<ImageData> data = const []})
    with _$ImageGenerationResponse {
  factory ImageGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationResponseFromJson(json);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class ImageData({
  final String? url,
  @JsonKey(name: 'b64_json') final String? base64Json,
}) with _$ImageData {
  ImageGenerationResult toDomain() {
    final normalizedUrl = url?.trim();
    if (normalizedUrl != null && normalizedUrl.isNotEmpty) {
      return ImageGenerationResult(url: normalizedUrl);
    }
    if (base64Json != null && base64Json!.isNotEmpty) {
      final encoded = base64Json!.contains(',')
          ? base64Json!.split(',').last
          : base64Json!;
      return ImageGenerationResult(
        bytes: Uint8List.fromList(base64Decode(encoded)),
      );
    }
    throw const FormatException('图片响应中没有 url 或 b64_json。');
  }

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);
}
