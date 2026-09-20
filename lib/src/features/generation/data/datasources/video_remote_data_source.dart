import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config_provider.dart';
import '../../../../core/network/api_client.dart';
import 'video_api.dart';
import '../models/video_api_models.dart';

part 'video_remote_data_source.g.dart';

abstract interface class VideoRemoteDataSource {
  Future<VideoJobResponse> create({required VideoCreateRequest request});

  Future<VideoJobResponse> poll({required String videoId});
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
  Future<VideoJobResponse> create({required VideoCreateRequest request}) {
    return client.execute(() => api.createVideo(request));
  }

  @override
  Future<VideoJobResponse> poll({required String videoId}) {
    return client.execute(
      () => api.pollVideo(videoId: videoId, modelName: model),
    );
  }
}
