// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCreateRequest _$VideoCreateRequestFromJson(
  Map<String, dynamic> json,
) => VideoCreateRequest(
  model: json['model'] as String,
  prompt: json['prompt'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  numFrames: (json['num_frames'] as num?)?.toInt(),
  frameRate: (json['frame_rate'] as num?)?.toDouble(),
  numInferenceSteps: (json['num_inference_steps'] as num?)?.toInt(),
  seed: (json['seed'] as num?)?.toInt(),
  negativePrompt: json['negative_prompt'] as String?,
  image: json['image'] as String?,
  mode: json['mode'] as String?,
  seconds: json['seconds'] as String?,
  size: json['size'] as String?,
  aspectRatio: json['aspect_ratio'] as String?,
  firstFrame: json['first_frame'] as String?,
  lastFrame: json['last_frame'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  audios: (json['audios'] as List<dynamic>?)?.map((e) => e as String).toList(),
  videos: (json['videos'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
  n: (json['n'] as num?)?.toInt(),
  extraBody: json['extra_body'] as Map<String, dynamic>?,
);

VideoJobResponse _$VideoJobResponseFromJson(Map<String, dynamic> json) =>
    VideoJobResponse(
      videoId: json['video_id'] as String?,
      id: json['id'] as String?,
      taskId: json['task_id'] as String?,
      status: json['status'] as String?,
      state: json['state'] as String?,
      progress: _numFromJson(json['progress']),
      percent: _numFromJson(json['percent']),
      progressPercent: _numFromJson(json['progress_percent']),
      url: json['url'] as String?,
      videoUrl: json['video_url'] as String?,
      videoUrlCamel: json['videoUrl'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
      seconds: _numFromJson(json['seconds']),
      size: json['size'] as String?,
      metadata: json['metadata'] == null
          ? null
          : VideoMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

VideoMetadata _$VideoMetadataFromJson(Map<String, dynamic> json) =>
    VideoMetadata(
      url: json['url'] as String?,
      seconds: _numFromJson(json['seconds']),
      message: json['message'] as String?,
      sizeMapping: json['size_mapping'] == null
          ? null
          : VideoSizeMapping.fromJson(
              json['size_mapping'] as Map<String, dynamic>,
            ),
    );

VideoSizeMapping _$VideoSizeMappingFromJson(Map<String, dynamic> json) =>
    VideoSizeMapping(
      actualSize: json['actual_size'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      resolution: json['resolution'] as String?,
      ratio: json['ratio'] as String?,
      message: json['message'] as String?,
    );
