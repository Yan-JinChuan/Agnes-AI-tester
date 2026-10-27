import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:agnes_ai_tester/src/core/lifecycle/app_lifecycle_provider.dart';
import 'package:agnes_ai_tester/src/features/generation/data/di/generation_data_providers.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/image_generation_record.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/image_generation_result.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_options.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_generation_record.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_job.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_job_status.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/repositories/image_repository.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/repositories/video_repository.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/viewmodels/image_generation_view_model.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/viewmodels/video_generation_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('image history selection toggles the result card', () {
    final record = _imageRecord(1);
    final container = ProviderContainer(
      overrides: [
        imageRepositoryProvider.overrideWithValue(
          _FakeImageRepository([record]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final viewModel = container.read(imageGenerationViewModelProvider.notifier);
    viewModel.selectHistory(record);
    expect(
      container.read(imageGenerationViewModelProvider).result,
      same(record),
    );

    viewModel.selectHistory(record);
    expect(container.read(imageGenerationViewModelProvider).result, isNull);
  });

  test(
    'deleting image history removes it and clears its open result',
    () async {
      final deleted = _imageRecord(1);
      final remaining = _imageRecord(2);
      final repository = _FakeImageRepository([deleted, remaining]);
      final container = ProviderContainer(
        overrides: [imageRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final viewModel = container.read(
        imageGenerationViewModelProvider.notifier,
      );
      await viewModel.loadHistory();
      viewModel.selectHistory(deleted);
      await viewModel.deleteHistory(deleted);

      final state = container.read(imageGenerationViewModelProvider);
      expect(state.history, [remaining]);
      expect(state.result, isNull);
      expect(repository.deletedIds, [1]);
    },
  );

  test('video history selection toggles the task card', () {
    final record = _videoRecord('video-1');
    final container = ProviderContainer(
      overrides: [
        videoRepositoryProvider.overrideWithValue(
          _FakeVideoRepository([record]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final viewModel = container.read(videoGenerationViewModelProvider.notifier);
    viewModel.selectHistory(record);
    expect(container.read(videoGenerationViewModelProvider).job?.id, 'video-1');

    viewModel.selectHistory(record);
    expect(container.read(videoGenerationViewModelProvider).job, isNull);
  });

  test('deleting video history removes it and closes its task card', () async {
    final deleted = _videoRecord('video-1');
    final remaining = _videoRecord('video-2');
    final repository = _FakeVideoRepository([deleted, remaining]);
    final container = ProviderContainer(
      overrides: [videoRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final viewModel = container.read(videoGenerationViewModelProvider.notifier);
    await viewModel.loadHistory();
    viewModel.selectHistory(deleted);
    await viewModel.deleteHistory(deleted);

    final state = container.read(videoGenerationViewModelProvider);
    expect(state.history, [remaining]);
    expect(state.job, isNull);
    expect(repository.deletedVideoIds, ['video-1']);
  });

  test(
    'refreshes running video jobs immediately after returning to foreground',
    () async {
      final running = _runningVideoRecord('video-running');
      final repository = _FakeVideoRepository([running]);
      final container = ProviderContainer(
        overrides: [videoRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        videoGenerationViewModelProvider,
        (_, __) {},
      );
      addTearDown(subscription.close);

      final viewModel = container.read(
        videoGenerationViewModelProvider.notifier,
      );
      final lifecycle = container.read(appLifecycleProvider.notifier);
      lifecycle.didChangeAppLifecycleState(AppLifecycleState.resumed);
      await viewModel.loadHistory();

      lifecycle.didChangeAppLifecycleState(AppLifecycleState.paused);
      lifecycle.didChangeAppLifecycleState(AppLifecycleState.resumed);
      await pumpEventQueue();

      expect(repository.historyCalls, 2);
      expect(repository.pollCalls, ['video-running']);
      expect(
        container.read(videoGenerationViewModelProvider).job?.isCompleted,
        isTrue,
      );
    },
  );
}

ImageGenerationRecord _imageRecord(int id) {
  return ImageGenerationRecord(
    id: id,
    prompt: 'image $id',
    model: 'image-model',
    size: '1024x1024',
    result: const ImageGenerationResult(url: 'https://example.com/image.png'),
    createdAt: DateTime(2026, 1, 1),
  );
}

VideoGenerationRecord _videoRecord(String videoId) {
  return VideoGenerationRecord(
    videoId: videoId,
    prompt: videoId,
    model: 'video-model',
    options: const VideoGenerationOptions(),
    status: VideoJobStatus.completed,
    progress: 100,
    url: 'https://example.com/video.mp4',
    error: null,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

VideoGenerationRecord _runningVideoRecord(String videoId) {
  return VideoGenerationRecord(
    videoId: videoId,
    prompt: videoId,
    model: 'video-model',
    options: const VideoGenerationOptions(),
    status: VideoJobStatus.processing,
    progress: 50,
    url: null,
    error: null,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

class _FakeImageRepository implements ImageRepository {
  _FakeImageRepository(this.records);

  final List<ImageGenerationRecord> records;
  final List<int> deletedIds = [];

  @override
  Future<List<ImageGenerationRecord>> history() async => records;

  @override
  Future<ImageGenerationRecord> generate({
    required String prompt,
    required String size,
  }) => throw UnimplementedError();

  @override
  Future<void> delete({required int id}) async {
    deletedIds.add(id);
  }
}

class _FakeVideoRepository implements VideoRepository {
  _FakeVideoRepository(this.records);

  final List<VideoGenerationRecord> records;
  final List<String> deletedVideoIds = [];
  int historyCalls = 0;
  final List<String> pollCalls = [];

  @override
  Future<List<VideoGenerationRecord>> history() async {
    historyCalls++;
    return records;
  }

  @override
  Future<VideoGenerationRecord> create({
    required String prompt,
    required VideoGenerationOptions options,
  }) => throw UnimplementedError();

  @override
  Future<VideoGenerationRecord> poll({required String videoId}) async {
    pollCalls.add(videoId);
    final current = records.firstWhere((record) => record.videoId == videoId);
    return current.updateFromJob(
      VideoJob(
        id: videoId,
        status: VideoJobStatus.completed,
        progress: 100,
        url: 'https://example.com/$videoId.mp4',
      ),
    );
  }

  @override
  Future<void> delete({required String videoId}) async {
    deletedVideoIds.add(videoId);
  }
}
