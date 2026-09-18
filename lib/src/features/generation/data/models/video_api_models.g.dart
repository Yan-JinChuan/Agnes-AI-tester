// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoCreateRequest _$VideoCreateRequestFromJson(Map<String, dynamic> json) =>
    _VideoCreateRequest(
      model: json['model'] as String,
      prompt: json['prompt'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      numFrames: (json['num_frames'] as num).toInt(),
      frameRate: (json['frame_rate'] as num).toDouble(),
      numInferenceSteps: (json['num_inference_steps'] as num?)?.toInt(),
      seed: (json['seed'] as num?)?.toInt(),
      negativePrompt: json['negative_prompt'] as String?,
      image: json['image'] as String?,
      mode: json['mode'] as String?,
      extraBody: json['extra_body'] as Map<String, dynamic>?,
    );

_VideoJobResponse _$VideoJobResponseFromJson(Map<String, dynamic> json) =>
    _VideoJobResponse(
      videoId: json['video_id'] as String?,
      id: json['id'] as String?,
      taskId: json['task_id'] as String?,
      status: json['status'] as String?,
      state: json['state'] as String?,
      progress: json['progress'] as num?,
      percent: json['percent'] as num?,
      progressPercent: json['progress_percent'] as num?,
      url: json['url'] as String?,
      videoUrl: json['video_url'] as String?,
      videoUrlCamel: json['videoUrl'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
      seconds: json['seconds'] as num?,
      size: json['size'] as String?,
      metadata: json['metadata'] == null
          ? null
          : VideoMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

_VideoMetadata _$VideoMetadataFromJson(Map<String, dynamic> json) =>
    _VideoMetadata(
      url: json['url'] as String?,
      seconds: json['seconds'] as num?,
      message: json['message'] as String?,
      sizeMapping: json['size_mapping'] == null
          ? null
          : VideoSizeMapping.fromJson(
              json['size_mapping'] as Map<String, dynamic>,
            ),
    );

_VideoSizeMapping _$VideoSizeMappingFromJson(Map<String, dynamic> json) =>
    _VideoSizeMapping(
      actualSize: json['actual_size'] as String?,
      message: json['message'] as String?,
    );
