import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/core/network/api_client.dart';
import 'package:agnes_ai_tester/src/features/generation/data/datasources/video_api.dart';
import 'package:agnes_ai_tester/src/features/generation/data/models/video_api_models.dart';
import 'package:agnes_ai_tester/src/features/generation/data/datasources/video_remote_data_source.dart';
import 'package:agnes_ai_tester/src/features/settings/data/datasources/model_catalog_api.dart';
import 'package:agnes_ai_tester/src/features/settings/data/models/model_catalog_api_models.dart';
import 'package:agnes_ai_tester/src/features/settings/data/datasources/model_catalog_remote_data_source.dart';

class _FakeApiClient implements ApiClient {
  @override
  Future<T> execute<T>(Future<T> Function() request) => request();
}

class _FakeVideoApi implements VideoApi {
  VideoJobResponse createResponse = const VideoJobResponse();
  VideoJobResponse pollResponse = const VideoJobResponse();

  VideoCreateRequest? lastCreateRequest;
  String? lastVideoId;
  String? lastModelName;

  @override
  Future<VideoJobResponse> createVideo(VideoCreateRequest request) async {
    lastCreateRequest = request;
    return createResponse;
  }

  @override
  Future<VideoJobResponse> pollVideo({
    required String videoId,
    required String modelName,
  }) async {
    lastVideoId = videoId;
    lastModelName = modelName;
    return pollResponse;
  }
}

class _FakeModelCatalogApi implements ModelCatalogApi {
  ModelCatalogResponse response = const ModelCatalogResponse();

  @override
  Future<ModelCatalogResponse> fetchModels() async => response;
}

void main() {
  test('Video data source builds the Agnes request', () async {
    final api = _FakeVideoApi()
      ..createResponse = const VideoJobResponse(
        videoId: 'video-1',
        status: 'queued',
        progress: 0,
      );
    final dataSource = VideoRemoteDataSourceImpl(
      client: _FakeApiClient(),
      api: api,
      model: 'agnes-video-v2.0',
    );
    const options = VideoGenerationOptions(
      width: 1024,
      height: 576,
      numFrames: 81,
      frameRate: 24,
      seed: 42,
      negativePrompt: 'blurry',
    );

    final job = await dataSource.create(
      prompt: 'A cinematic ocean',
      options: options,
    );

    expect(api.lastCreateRequest?.toJson(), {
      'model': 'agnes-video-v2.0',
      'prompt': 'A cinematic ocean',
      'width': 1024,
      'height': 576,
      'num_frames': 81,
      'frame_rate': 24.0,
      'seed': 42,
      'negative_prompt': 'blurry',
    });
    expect(job.id, 'video-1');
  });

  test('Video data source passes polling parameters to Retrofit', () async {
    final api = _FakeVideoApi()
      ..pollResponse = const VideoJobResponse(
        videoId: 'video-1',
        status: 'completed',
        progress: 100,
        seconds: 3.375,
        size: '832x448',
        metadata: VideoMetadata(
          url: 'https://example.com/video.mp4',
          sizeMapping: VideoSizeMapping(message: 'mapped to 480p/16:9'),
        ),
      );
    final dataSource = VideoRemoteDataSourceImpl(
      client: _FakeApiClient(),
      api: api,
      model: 'agnes-video-v2.0',
    );

    final job = await dataSource.poll(videoId: 'video-1');

    expect(api.lastVideoId, 'video-1');
    expect(api.lastModelName, 'agnes-video-v2.0');
    expect(job.url, 'https://example.com/video.mp4');
    expect(job.seconds, 3.375);
    expect(job.actualSize, '832x448');
    expect(job.metadataMessage, 'mapped to 480p/16:9');
  });

  test('Model catalog reads an OpenAI-compatible models response', () async {
    final api = _FakeModelCatalogApi()
      ..response = const ModelCatalogResponse(
        data: [
          {'id': 'z-model', 'owned_by': 'agnes'},
          {'name': 'a-model'},
          'manual-model',
        ],
      );
    final dataSource = AgnesModelCatalogRemoteDataSource(
      client: _FakeApiClient(),
      api: api,
    );

    final models = await dataSource.fetchModels();

    expect(models.map((model) => model.id).toList(), [
      'a-model',
      'manual-model',
      'z-model',
    ]);
    expect(models.last.ownedBy, 'agnes');
  });
}
