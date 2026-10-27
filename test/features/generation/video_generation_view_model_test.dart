import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_options.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_record.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_job_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/features/generation/data/di/generation_data_providers.dart';
import 'package:agnes_ai_tester/src/features/generation/data/datasources/video_local_data_source.dart';
import 'package:agnes_ai_tester/src/features/generation/data/datasources/video_remote_data_source.dart';
import 'package:agnes_ai_tester/src/features/generation/data/models/video_api_models.dart';
import 'package:agnes_ai_tester/src/features/generation/data/repositories/video_repository_impl.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/viewmodels/video_generation_view_model.dart';

void main() {
  test('builds validated video options in the ViewModel', () async {
    final repository = _RecordingVideoRepository();
    final container = ProviderContainer(
      overrides: [videoRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final viewModel = container.read(videoGenerationViewModelProvider.notifier);
    viewModel.setPrompt('  a cinematic test  ');
    viewModel.setDimensionPreset('portrait');
    viewModel.setNumFrames('121');
    viewModel.setFrameRate('30');
    viewModel.setKeyframeUrls(
      'https://one.example/a.png\n, https://two.example/b.png',
    );
    viewModel.setMode('keyframes');
    await viewModel.create();

    expect(repository.prompt, 'a cinematic test');
    expect(repository.options?.width, 768);
    expect(repository.options?.height, 1152);
    expect(repository.options?.frameRate, 30);
    expect(repository.options?.keyframeUrls, [
      'https://one.example/a.png',
      'https://two.example/b.png',
    ]);
    expect(container.read(videoGenerationViewModelProvider).error, isNull);
  });

  test(
    'keeps invalid video form values in the ViewModel error state',
    () async {
      final repository = _RecordingVideoRepository();
      final container = ProviderContainer(
        overrides: [videoRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final viewModel = container.read(
        videoGenerationViewModelProvider.notifier,
      );
      viewModel.setPrompt('test');
      viewModel.setNumFrames('120');
      await viewModel.create();

      expect(repository.prompt, isNull);
      expect(
        container.read(videoGenerationViewModelProvider).error,
        contains('8n+1'),
      );
    },
  );

  test('keeps video history when the repository is rebuilt', () async {
    final initialRecord = _record('video-1', 'initial');
    final refreshedRecord = _record('video-2', 'refreshed');
    final initialRepository = _FakeVideoRepository([initialRecord]);
    final refreshedRepository = _FakeVideoRepository([refreshedRecord]);
    final repositoryState = StateProvider<VideoRepositoryImpl>(
      (_) => initialRepository,
    );
    final container = ProviderContainer(
      overrides: [
        videoRepositoryProvider.overrideWith(
          (ref) => ref.watch(repositoryState),
        ),
      ],
    );
    final subscription = container.listen<VideoState>(
      videoGenerationViewModelProvider,
      (_, __) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    addTearDown(container.dispose);

    final controller = container.read(
      videoGenerationViewModelProvider.notifier,
    );
    await controller.loadHistory();
    expect(container.read(videoGenerationViewModelProvider).history, [
      initialRecord,
    ]);

    container.read(repositoryState.notifier).state = refreshedRepository;
    await Future<void>.delayed(Duration.zero);
    expect(container.read(videoGenerationViewModelProvider).history, [
      initialRecord,
    ]);

    await controller.loadHistory();
    expect(container.read(videoGenerationViewModelProvider).history, [
      refreshedRecord,
    ]);
  });
}

VideoGenerationRecord _record(String videoId, String prompt) {
  final now = DateTime(2026, 1, 1);
  return VideoGenerationRecord(
    videoId: videoId,
    prompt: prompt,
    model: 'test-model',
    status: VideoJobStatus.completed,
    progress: 100,
    createdAt: now,
    updatedAt: now,
  );
}

class _FakeVideoRepository extends VideoRepositoryImpl {
  _FakeVideoRepository(this._records)
    : super(
        remote: _UnusedVideoRemote(),
        local: _UnusedVideoLocal(),
        model: 'test-model',
      );

  final List<VideoGenerationRecord> _records;

  @override
  Future<List<VideoGenerationRecord>> history() async => _records;
}

class _RecordingVideoRepository extends VideoRepositoryImpl {
  _RecordingVideoRepository()
    : super(
        remote: _UnusedVideoRemote(),
        local: _UnusedVideoLocal(),
        model: 'test-model',
      );

  String? prompt;
  VideoGenerationOptions? options;

  @override
  Future<VideoGenerationRecord> create({
    required String prompt,
    required VideoGenerationOptions options,
  }) async {
    this.prompt = prompt;
    this.options = options;
    final now = DateTime(2026, 1, 1);
    return VideoGenerationRecord(
      videoId: 'recorded-video',
      prompt: prompt,
      model: 'test-model',
      options: options,
      status: VideoJobStatus.queued,
      progress: 0,
      createdAt: now,
      updatedAt: now,
    );
  }
}

class _UnusedVideoRemote implements VideoRemoteDataSource {
  @override
  Future<VideoJobResponse> create({required VideoCreateRequest request}) =>
      throw UnimplementedError();

  @override
  Future<VideoJobResponse> poll({required String videoId}) =>
      throw UnimplementedError();
}

class _UnusedVideoLocal implements VideoLocalDataSource {
  @override
  Future<List<Map<String, Object?>>> loadHistory() =>
      throw UnimplementedError();

  @override
  Future<Map<String, Object?>?> findByVideoId(String videoId) =>
      throw UnimplementedError();

  @override
  Future<int> insertGeneration(Map<String, Object?> values) =>
      throw UnimplementedError();

  @override
  Future<void> updateGeneration({
    required String videoId,
    required Map<String, Object?> values,
  }) => throw UnimplementedError();

  @override
  Future<void> deleteGeneration({required String videoId}) =>
      throw UnimplementedError();
}
