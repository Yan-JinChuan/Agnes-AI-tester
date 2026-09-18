import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_api_models.freezed.dart';
part 'image_api_models.g.dart';

@Freezed(toJson: false)
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
class ImageGenerationResponse({final List<ImageData> data = const []})
    with _$ImageGenerationResponse {
  factory ImageGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationResponseFromJson(json);
}

@Freezed(toJson: false)
class ImageData({
  final String? url,
  @JsonKey(name: 'b64_json') final String? base64Json,
}) with _$ImageData {
  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);
}
