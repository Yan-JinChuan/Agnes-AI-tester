import 'dart:convert';

import 'package:drift/drift.dart' show Value;

import '../../../../core/network/api_exception.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/models/video_generation_options.dart';
import '../../domain/models/video_generation_record.dart';
import '../../domain/models/video_job.dart';
import '../../domain/models/video_job_status.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/video_local_data_source.dart';
import '../datasources/video_remote_data_source.dart';
import '../models/video_api_models.dart';

/// 协调视频接口与本地历史，并在 Repository 边界转换 DTO、Drift 行和领域记录。
class VideoRepositoryImpl implements VideoRepository {
  const VideoRepositoryImpl({
    required this.remote,
    required this.local,
    required this.model,
  });

  final VideoRemoteDataSource remote;
  final VideoLocalDataSource local;
  final String model;

  /// 读取视频历史并恢复为领域记录。
  @override
  Future<List<VideoGenerationRecord>> history() async {
    final rows = await local.loadHistory();
    return rows.map(_fromRow).toList();
  }

  /// 提交视频任务并保存完整请求选项与初始状态。
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

  /// 查询任务状态，并插入或更新相应的本地记录。
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

  /// 删除指定视频任务对应的本地历史。
  @override
  Future<void> delete({required String videoId}) {
    return local.deleteGeneration(videoId: videoId);
  }

  /// 在 Repository 边界把远程 DTO 清洗为领域任务。
  VideoJob _toDomain(VideoJobResponse response, {String? fallbackId}) {
    try {
      return response.toDomain(fallbackId: fallbackId);
    } on FormatException catch (error) {
      throw ApiException(message: error.message);
    }
  }

  /// 将 Drift 视频行还原为领域记录及其请求选项。
  VideoGenerationRecord _fromRow(VideoGenerationRow row) {
    return VideoGenerationRecord(
      id: row.id,
      videoId: row.videoId,
      prompt: row.prompt,
      model: row.model,
      options: _optionsFromStorage(row.requestJson),
      status: VideoJobStatus.fromWireValue(row.status),
      progress: row.progress.clamp(0, 100),
      url: row.url?.trim(),
      error: row.error?.trim(),
      actualSize: row.actualSize?.trim(),
      seconds: row.seconds,
      metadataMessage: row.metadataMessage?.trim(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
    );
  }

  /// 将领域记录映射为 Drift companion，供新增和更新共用。
  VideoGenerationsCompanion _toRow(VideoGenerationRecord record) {
    return VideoGenerationsCompanion.insert(
      videoId: record.videoId,
      prompt: record.prompt,
      model: record.model,
      status: record.status.wireValue,
      progress: Value(record.progress),
      url: Value(record.url),
      error: Value(record.error),
      requestJson: Value(jsonEncode(_optionsToStorage(record.options))),
      actualSize: Value(record.actualSize),
      seconds: Value(record.seconds),
      metadataMessage: Value(record.metadataMessage),
      createdAt: record.createdAt.millisecondsSinceEpoch,
      updatedAt: record.updatedAt.millisecondsSinceEpoch,
    );
  }

  /// 将请求选项转换为稳定的 JSON 字段，供历史记录持久化。
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
      'seconds': options.seconds,
      'size': options.size,
      'aspect_ratio': options.aspectRatio,
      'first_frame': options.firstFrame,
      'last_frame': options.lastFrame,
      'image_urls': options.imageUrls,
      'audio_urls': options.audioUrls,
      'reference_videos': options.referenceVideos
          .map(
            (video) => {
              'url': video.url,
              'start_seconds': video.startSeconds,
              'require_audio': video.requireAudio,
            },
          )
          .toList(),
    };
  }

  /// 从历史 JSON 还原请求选项；损坏或缺失字段使用领域默认值。
  VideoGenerationOptions _optionsFromStorage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return const VideoGenerationOptions();
    }
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        final map = Map<String, dynamic>.from(decoded);
        final keyframes = map['keyframe_urls'];
        final images = map['image_urls'];
        final audios = map['audio_urls'];
        final videos = map['reference_videos'];
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
          seconds: _nullableText(map['seconds']) ?? '5',
          size: _nullableText(map['size']) ?? '720P',
          aspectRatio: _nullableText(map['aspect_ratio']) ?? '16:9',
          firstFrame: _nullableText(map['first_frame']),
          lastFrame: _nullableText(map['last_frame']),
          imageUrls: images is List
              ? images.whereType<String>().toList()
              : const [],
          audioUrls: audios is List
              ? audios.whereType<String>().toList()
              : const [],
          referenceVideos: videos is List
              ? videos
                    .whereType<Map>()
                    .map(
                      (video) => VideoReference(
                        url: video['url']?.toString() ?? '',
                        startSeconds: _doubleValue(video['start_seconds'], 0),
                        requireAudio: video['require_audio'] == true,
                      ),
                    )
                    .where((video) => video.url.isNotEmpty)
                    .toList()
              : const [],
        );
      }
    } on FormatException {
      // 请求参数损坏时仍保留任务状态，避免历史记录无法打开。
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

  String? _nullableText(Object? value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }
}
