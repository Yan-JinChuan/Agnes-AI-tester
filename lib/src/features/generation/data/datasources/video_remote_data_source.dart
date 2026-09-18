import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config_provider.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/models/video_generation_options.dart';
import '../../domain/models/video_job.dart';
import 'video_api.dart';
import '../models/video_api_models.dart';

part 'video_remote_data_source.g.dart';

abstract interface class VideoRemoteDataSource {
  Future<VideoJob> create({
    required String prompt,
    required VideoGenerationOptions options,
  });

  Future<VideoJob> poll({required String videoId});
}

@riverpod
VideoRemoteDataSource videoRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return VideoRemoteDataSourceImpl(
    client: client,
    api: VideoApi(client.dio),
    model: ref.watch(appConfigProvider).videoModel,
  );
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  const VideoRemoteDataSourceImpl({
    required this.client,
    required this.api,
    required this.model,
  });

  final ApiClient client;
  final VideoApi api;
  final String model;

  @override
  Future<VideoJob> create({
    required String prompt,
    required VideoGenerationOptions options,
  }) async {
    final response = await client.execute(
      () => api.createVideo(
        VideoCreateRequest(
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
        ),
      ),
    );
    return _videoJobFrom(response);
  }

  @override
  Future<VideoJob> poll({required String videoId}) async {
    final response = await client.execute(
      () => api.pollVideo(videoId: videoId, modelName: model),
    );
    return _videoJobFrom(response, fallbackId: videoId);
  }

  VideoJob _videoJobFrom(VideoJobResponse response, {String? fallbackId}) {
    final metadata = response.metadata;
    final sizeMapping = metadata?.sizeMapping;
    final id = response.videoId ?? response.id ?? response.taskId ?? fallbackId;
    if (id == null || id.isEmpty) {
      throw const ApiException(message: '视频接口没有返回 video_id。');
    }
    final rawProgress =
        response.progress ?? response.percent ?? response.progressPercent;
    final progress = rawProgress?.round().clamp(0, 100) ?? 0;
    final rawUrl =
        response.url ??
        response.videoUrl ??
        response.videoUrlCamel ??
        metadata?.url;
    final rawError = response.error ?? response.message;
    final rawSeconds = response.seconds ?? metadata?.seconds;
    final rawSize = response.size ?? sizeMapping?.actualSize;
    final rawMessage = sizeMapping?.message ?? metadata?.message;
    return VideoJob(
      id: id,
      status: response.status ?? response.state ?? 'queued',
      progress: progress,
      url: _trimmed(rawUrl),
      error: _trimmed(rawError),
      actualSize: _trimmed(rawSize),
      seconds: rawSeconds?.toDouble(),
      metadataMessage: _trimmed(rawMessage),
    );
  }

  String? _trimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
