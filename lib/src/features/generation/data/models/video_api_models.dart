import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/video_generation_options.dart';
import '../../domain/models/video_job.dart';
import '../../domain/models/video_job_status.dart';

part 'video_api_models.freezed.dart';
part 'video_api_models.g.dart';

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class const VideoCreateRequest({
  required final String model,
  required final String prompt,
  final int? width,
  final int? height,
  @JsonKey(name: 'num_frames') final int? numFrames,
  @JsonKey(name: 'frame_rate') final double? frameRate,
  @JsonKey(name: 'num_inference_steps', includeIfNull: false)
  final int? numInferenceSteps,
  @JsonKey(includeIfNull: false) final int? seed,
  @JsonKey(name: 'negative_prompt', includeIfNull: false)
  final String? negativePrompt,
  @JsonKey(includeIfNull: false) final String? image,
  @JsonKey(includeIfNull: false) final String? mode,
  @JsonKey(includeIfNull: false) final String? seconds,
  @JsonKey(includeIfNull: false) final String? size,
  @JsonKey(name: 'aspect_ratio', includeIfNull: false)
  final String? aspectRatio,
  @JsonKey(name: 'first_frame', includeIfNull: false) final String? firstFrame,
  @JsonKey(name: 'last_frame', includeIfNull: false) final String? lastFrame,
  @JsonKey(includeIfNull: false) final List<String>? images,
  @JsonKey(includeIfNull: false) final List<String>? audios,
  @JsonKey(includeIfNull: false) final List<Map<String, dynamic>>? videos,
  @JsonKey(includeIfNull: false) final int? n,
  @JsonKey(name: 'extra_body', includeIfNull: false)
  final Map<String, dynamic>? extraBody,
}) with _$VideoCreateRequest {
  factory VideoCreateRequest.fromDomain({
    required String model,
    required String prompt,
    required VideoGenerationOptions options,
  }) {
    if (isAgnesVideo25OrLater(model)) {
      return VideoCreateRequest(
        model: model,
        prompt: prompt,
        seed: options.seed,
        mode: options.mode ?? 'text',
        seconds: options.seconds,
        size: options.size,
        aspectRatio: options.aspectRatio,
        firstFrame: _trimmed(options.firstFrame),
        lastFrame: _trimmed(options.lastFrame),
        images: _trimmedList(options.imageUrls),
        audios: _trimmedList(options.audioUrls),
        videos: options.referenceVideos.isEmpty
            ? null
            : options.referenceVideos
                  .map(
                    (video) => {
                      'url': video.url,
                      if (video.startSeconds > 0)
                        'start_seconds': video.startSeconds,
                      if (video.requireAudio) 'require_audio': true,
                    },
                  )
                  .toList(),
        n: 1,
      );
    }

    return VideoCreateRequest(
      model: model,
      prompt: prompt,
      width: options.width,
      height: options.height,
      numFrames: options.numFrames,
      frameRate: options.frameRate,
      numInferenceSteps: options.numInferenceSteps,
      seed: options.seed,
      negativePrompt: _trimmed(options.negativePrompt),
      image: _trimmed(options.imageUrl),
      mode: _trimmed(options.mode),
      extraBody: options.keyframeUrls.isEmpty
          ? null
          : {
              'image': options.keyframeUrls,
              'mode': _trimmed(options.mode) ?? 'keyframes',
            },
    );
  }

  Map<String, dynamic> toJson() => {
    'model': model,
    'prompt': prompt,
    if (width != null) 'width': width,
    if (height != null) 'height': height,
    if (numFrames != null) 'num_frames': numFrames,
    if (frameRate != null) 'frame_rate': frameRate,
    if (numInferenceSteps != null) 'num_inference_steps': numInferenceSteps,
    if (seed != null) 'seed': seed,
    if (negativePrompt != null) 'negative_prompt': negativePrompt,
    if (image != null) 'image': image,
    if (mode != null) 'mode': mode,
    if (seconds != null) 'seconds': seconds,
    if (size != null) 'size': size,
    if (aspectRatio != null) 'aspect_ratio': aspectRatio,
    if (firstFrame != null) 'first_frame': firstFrame,
    if (lastFrame != null) 'last_frame': lastFrame,
    if (images != null) 'images': images,
    if (audios != null) 'audios': audios,
    if (videos != null) 'videos': videos,
    if (n != null) 'n': n,
    if (extraBody != null) 'extra_body': extraBody,
  };

  factory VideoCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$VideoCreateRequestFromJson(json);
}

List<String>? _trimmedList(List<String> values) {
  final trimmed = values
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();
  return trimmed.isEmpty ? null : trimmed;
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class const VideoJobResponse({
  @JsonKey(name: 'video_id') final String? videoId,
  final String? id,
  @JsonKey(name: 'task_id') final String? taskId,
  final String? status,
  final String? state,
  @JsonKey(fromJson: _numFromJson) final num? progress,
  @JsonKey(fromJson: _numFromJson) final num? percent,
  @JsonKey(name: 'progress_percent', fromJson: _numFromJson)
  final num? progressPercent,
  final String? url,
  @JsonKey(name: 'video_url') final String? videoUrl,
  @JsonKey(name: 'videoUrl') final String? videoUrlCamel,
  final String? error,
  final String? message,
  @JsonKey(fromJson: _numFromJson) final num? seconds,
  final String? size,
  final VideoMetadata? metadata,
}) with _$VideoJobResponse {
  VideoJob toDomain({String? fallbackId}) {
    final metadataValue = metadata;
    final sizeMapping = metadataValue?.sizeMapping;
    final id = videoId ?? this.id ?? taskId ?? fallbackId;
    if (id == null || id.isEmpty) {
      throw const FormatException('视频接口没有返回 video_id。');
    }
    final rawProgress = progress ?? percent ?? progressPercent;
    final rawUrl = url ?? videoUrl ?? videoUrlCamel ?? metadataValue?.url;
    final rawError = error ?? message;
    final rawSeconds = seconds ?? metadataValue?.seconds;
    final mappedSize = sizeMapping?.width != null && sizeMapping?.height != null
        ? '${sizeMapping!.width}x${sizeMapping.height}'
        : sizeMapping?.actualSize ?? sizeMapping?.resolution;
    final rawSize = mappedSize ?? size;
    final rawMessage = sizeMapping?.message ?? metadataValue?.message;
    return VideoJob(
      id: id,
      status: VideoJobStatus.fromWireValue(status ?? state),
      progress: rawProgress?.round().clamp(0, 100) ?? 0,
      url: _trimmed(rawUrl),
      error: _trimmed(rawError),
      actualSize: _trimmed(rawSize),
      seconds: rawSeconds?.toDouble(),
      metadataMessage: _trimmed(rawMessage),
    );
  }

  factory VideoJobResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoJobResponseFromJson(json);
}

String? _trimmed(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

num? _numFromJson(Object? value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(value.toString().trim());
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class const VideoMetadata({
  final String? url,
  @JsonKey(fromJson: _numFromJson) final num? seconds,
  final String? message,
  @JsonKey(name: 'size_mapping') final VideoSizeMapping? sizeMapping,
}) with _$VideoMetadata {
  factory VideoMetadata.fromJson(Map<String, dynamic> json) =>
      _$VideoMetadataFromJson(json);
}

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class const VideoSizeMapping({
  @JsonKey(name: 'actual_size') final String? actualSize,
  final int? width,
  final int? height,
  final String? resolution,
  final String? ratio,
  final String? message,
}) with _$VideoSizeMapping {
  factory VideoSizeMapping.fromJson(Map<String, dynamic> json) =>
      _$VideoSizeMappingFromJson(json);
}
