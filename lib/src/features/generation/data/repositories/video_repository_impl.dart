import 'dart:convert';

import '../../../../core/network/api_exception.dart';
import '../../domain/models/video_generation_options.dart';
import '../../domain/models/video_generation_record.dart';
import '../../domain/models/video_job.dart';
import '../../domain/models/video_job_status.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/video_local_data_source.dart';
import '../datasources/video_remote_data_source.dart';
import '../models/video_api_models.dart';

class VideoRepositoryImpl implements VideoRepository {
  const VideoRepositoryImpl({
    required this.remote,
    required this.local,
    required this.model,
  });

  final VideoRemoteDataSource remote;
  final VideoLocalDataSource local;
  final String model;

  @override
  Future<List<VideoGenerationRecord>> history() async {
    final rows = await local.loadHistory();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<VideoGenerationRecord> create({
    required String prompt,
    required VideoGenerationOptions options,
  }) async {
    final response = await remote.create(
      request: VideoCreateRequest.fromDomain(
        model: model,
        prompt: prompt,
        options: options,
      ),
    );
    final job = _toDomain(response);
    final now = DateTime.now();
    final record = VideoGenerationRecord(
      videoId: job.id,
      prompt: prompt,
      model: model,
      options: options,
      status: job.status,
      progress: job.progress,
      url: job.url,
      error: job.error,
      actualSize: job.actualSize,
      seconds: job.seconds,
      metadataMessage: job.metadataMessage,
      createdAt: now,
      updatedAt: now,
    );
    await local.insertGeneration(_toRow(record));
    return record;
  }

  @override
  Future<VideoGenerationRecord> poll({required String videoId}) async {
    final existingRow = await local.findByVideoId(videoId);
    final job = _toDomain(
      await remote.poll(videoId: videoId),
      fallbackId: videoId,
    );
    final record = existingRow == null
        ? VideoGenerationRecord(
            videoId: job.id,
            prompt: '',
            model: model,
            status: job.status,
            progress: job.progress,
            url: job.url,
            error: job.error,
            actualSize: job.actualSize,
            seconds: job.seconds,
            metadataMessage: job.metadataMessage,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          )
        : _fromRow(existingRow).updateFromJob(job);
    if (existingRow == null) {
      await local.insertGeneration(_toRow(record));
    } else {
      await local.updateGeneration(videoId: videoId, values: _toRow(record));
    }
    return record;
  }

  VideoJob _toDomain(VideoJobResponse response, {String? fallbackId}) {
    try {
      return response.toDomain(fallbackId: fallbackId);
    } on FormatException catch (error) {
      throw ApiException(message: error.message);
    }
  }

  VideoGenerationRecord _fromRow(Map<String, Object?> row) {
    return VideoGenerationRecord(
      id: row['id'] as int?,
      videoId: row['video_id'] as String,
      prompt: row['prompt'] as String? ?? '',
      model: row['model'] as String? ?? '',
      options: _optionsFromStorage(row['request_json'] as String?),
      status: VideoJobStatus.fromWireValue(row['status']),
      progress: (row['progress'] as int? ?? 0).clamp(0, 100),
      url: (row['url'] as String?)?.trim(),
      error: (row['error'] as String?)?.trim(),
      actualSize: (row['actual_size'] as String?)?.trim(),
      seconds: _nullableDouble(row['seconds']),
      metadataMessage: (row['metadata_message'] as String?)?.trim(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int),
    );
  }

  Map<String, Object?> _toRow(VideoGenerationRecord record) {
    return {
      'video_id': record.videoId,
      'prompt': record.prompt,
      'model': record.model,
      'request_json': jsonEncode(_optionsToStorage(record.options)),
      'status': record.status.wireValue,
      'progress': record.progress,
      'url': record.url,
      'error': record.error,
      'actual_size': record.actualSize,
      'seconds': record.seconds,
      'metadata_message': record.metadataMessage,
      'created_at': record.createdAt.millisecondsSinceEpoch,
      'updated_at': record.updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, Object?> _optionsToStorage(VideoGenerationOptions options) {
    return {
      'width': options.width,
      'height': options.height,
      'num_frames': options.numFrames,
      'frame_rate': options.frameRate,
      'num_inference_steps': options.numInferenceSteps,
      'seed': options.seed,
      'negative_prompt': options.negativePrompt,
      'image_url': options.imageUrl,
      'mode': options.mode,
      'keyframe_urls': options.keyframeUrls,
    };
  }

  VideoGenerationOptions _optionsFromStorage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return const VideoGenerationOptions();
    }
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        final map = Map<String, dynamic>.from(decoded);
        final keyframes = map['keyframe_urls'];
        return VideoGenerationOptions(
          width: _intValue(map['width'], 1152),
          height: _intValue(map['height'], 768),
          numFrames: _intValue(map['num_frames'], 121),
          frameRate: _doubleValue(map['frame_rate'], 24),
          numInferenceSteps: _nullableInt(map['num_inference_steps']),
          seed: _nullableInt(map['seed']),
          negativePrompt: _nullableText(map['negative_prompt']),
          imageUrl: _nullableText(map['image_url']),
          mode: _nullableText(map['mode']),
          keyframeUrls: keyframes is List
              ? keyframes.whereType<String>().toList()
              : const [],
        );
      }
    } on FormatException {
      // Fallback to documented defaults for old/corrupt records.
    }
    return const VideoGenerationOptions();
  }

  int _intValue(Object? value, int fallback) {
    if (value is num) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  int? _nullableInt(Object? value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    return _intValue(value, 0);
  }

  double _doubleValue(Object? value, double fallback) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? fallback;
  }

  double? _nullableDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  String? _nullableText(Object? value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }
}
