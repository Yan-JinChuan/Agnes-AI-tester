import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_api_models.freezed.dart';
part 'video_api_models.g.dart';

@Freezed(toJson: false)
class const VideoCreateRequest({
  required final String model,
  required final String prompt,
  required final int width,
  required final int height,
  @JsonKey(name: 'num_frames') required final int numFrames,
  @JsonKey(name: 'frame_rate') required final double frameRate,
  @JsonKey(name: 'num_inference_steps', includeIfNull: false)
  final int? numInferenceSteps,
  @JsonKey(includeIfNull: false) final int? seed,
  @JsonKey(name: 'negative_prompt', includeIfNull: false)
  final String? negativePrompt,
  @JsonKey(includeIfNull: false) final String? image,
  @JsonKey(includeIfNull: false) final String? mode,
  @JsonKey(name: 'extra_body', includeIfNull: false)
  final Map<String, dynamic>? extraBody,
}) with _$VideoCreateRequest {
  Map<String, dynamic> toJson() => {
    'model': model,
    'prompt': prompt,
    'width': width,
    'height': height,
    'num_frames': numFrames,
    'frame_rate': frameRate,
    if (numInferenceSteps != null) 'num_inference_steps': numInferenceSteps,
    if (seed != null) 'seed': seed,
    if (negativePrompt != null) 'negative_prompt': negativePrompt,
    if (image != null) 'image': image,
    if (mode != null) 'mode': mode,
    if (extraBody != null) 'extra_body': extraBody,
  };

  factory VideoCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$VideoCreateRequestFromJson(json);
}

@Freezed(toJson: false)
class const VideoJobResponse({
  @JsonKey(name: 'video_id') final String? videoId,
  final String? id,
  @JsonKey(name: 'task_id') final String? taskId,
  final String? status,
  final String? state,
  final num? progress,
  final num? percent,
  @JsonKey(name: 'progress_percent') final num? progressPercent,
  final String? url,
  @JsonKey(name: 'video_url') final String? videoUrl,
  @JsonKey(name: 'videoUrl') final String? videoUrlCamel,
  final String? error,
  final String? message,
  final num? seconds,
  final String? size,
  final VideoMetadata? metadata,
}) with _$VideoJobResponse {
  factory VideoJobResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoJobResponseFromJson(json);
}

@Freezed(toJson: false)
class const VideoMetadata({
  final String? url,
  final num? seconds,
  final String? message,
  @JsonKey(name: 'size_mapping') final VideoSizeMapping? sizeMapping,
}) with _$VideoMetadata {
  factory VideoMetadata.fromJson(Map<String, dynamic> json) =>
      _$VideoMetadataFromJson(json);
}

@Freezed(toJson: false)
class const VideoSizeMapping({
  @JsonKey(name: 'actual_size') final String? actualSize,
  final String? message,
}) with _$VideoSizeMapping {
  factory VideoSizeMapping.fromJson(Map<String, dynamic> json) =>
      _$VideoSizeMappingFromJson(json);
}
