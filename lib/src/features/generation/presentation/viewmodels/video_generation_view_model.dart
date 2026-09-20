import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/core/utils/error_message.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/di/generation_data_providers.dart';
import '../../domain/models/video_generation_options.dart';
import '../../domain/models/video_generation_record.dart';
import '../../domain/models/video_job.dart';
import '../../domain/repositories/video_repository.dart';

part 'video_generation_view_model.freezed.dart';
part 'video_generation_view_model.g.dart';

@freezed
class const VideoState({
  final String prompt = '',
  final String dimensionPreset = 'standard',
  final String width = '1152',
  final String height = '768',
  final String numFrames = '121',
  final String frameRate = '24',
  final String mode = '',
  final String imageUrl = '',
  final String keyframeUrls = '',
  final String numInferenceSteps = '',
  final String seed = '',
  final String negativePrompt = '',
  final String seconds = '5',
  final String size = '720P',
  final String aspectRatio = '16:9',
  final String firstFrame = '',
  final String lastFrame = '',
  final String imageUrls = '',
  final String audioUrls = '',
  final String referenceVideoUrl = '',
  final String referenceVideoStartSeconds = '0',
  final bool referenceVideoRequireAudio = false,
  final VideoJob? job,
  final List<VideoGenerationRecord> history = const [],
  final bool isLoading = false,
  final String? error,
}) with _$VideoState;

extension VideoStateSelection on VideoState {
  VideoGenerationRecord? get currentRecord {
    final jobId = job?.id;
    if (jobId == null) return null;
    for (final record in history) {
      if (record.videoId == jobId) return record;
    }
    return null;
  }
}

@riverpod
class VideoGenerationViewModel extends _$VideoGenerationViewModel {
  late VideoRepository _repository;
  Timer? _pollTimer;

  @override
  VideoState build() {
    ref.listen(videoRepositoryProvider, (_, repository) {
      _repository = repository;
    }, fireImmediately: true);
    ref.onDispose(() => _pollTimer?.cancel());
    return const VideoState();
  }

  void setPrompt(String value) => state = state.copyWith(prompt: value);

  void setWidth(String value) => state = state.copyWith(width: value);

  void setHeight(String value) => state = state.copyWith(height: value);

  void setNumFrames(String value) => state = state.copyWith(numFrames: value);

  void setFrameRate(String value) => state = state.copyWith(frameRate: value);

  void setMode(String? value) {
    final mode = value ?? '';
    state = state.copyWith(
      mode: mode,
      firstFrame: mode == 'keyframe' ? state.firstFrame : '',
      lastFrame: mode == 'keyframe' ? state.lastFrame : '',
      imageUrls: mode == 'reference' ? state.imageUrls : '',
      audioUrls: mode == 'reference' ? state.audioUrls : '',
      referenceVideoUrl: mode == 'reference' ? state.referenceVideoUrl : '',
    );
  }

  void setImageUrl(String value) => state = state.copyWith(imageUrl: value);

  void setKeyframeUrls(String value) =>
      state = state.copyWith(keyframeUrls: value);

  void setNumInferenceSteps(String value) =>
      state = state.copyWith(numInferenceSteps: value);

  void setSeed(String value) => state = state.copyWith(seed: value);

  void setNegativePrompt(String value) =>
      state = state.copyWith(negativePrompt: value);

  void setSeconds(String value) => state = state.copyWith(seconds: value);

  void setSize(String? value) {
    if (value != null) state = state.copyWith(size: value);
  }

  void setAspectRatio(String? value) {
    if (value != null) state = state.copyWith(aspectRatio: value);
  }

  void setFirstFrame(String value) => state = state.copyWith(firstFrame: value);

  void setLastFrame(String value) => state = state.copyWith(lastFrame: value);

  void setImageUrls(String value) => state = state.copyWith(imageUrls: value);

  void setAudioUrls(String value) => state = state.copyWith(audioUrls: value);

  void setReferenceVideoUrl(String value) =>
      state = state.copyWith(referenceVideoUrl: value);

  void setReferenceVideoStartSeconds(String value) =>
      state = state.copyWith(referenceVideoStartSeconds: value);

  void setReferenceVideoRequireAudio(bool value) =>
      state = state.copyWith(referenceVideoRequireAudio: value);

  void setDimensionPreset(String? value) {
    if (value == null) return;
    final dimensions = switch (value) {
      'landscape' => (1152, 768),
      'portrait' => (768, 1152),
      'square' => (768, 768),
      'fourThree' => (1024, 768),
      'threeFour' => (768, 1024),
      _ => (1152, 768),
    };
    state = state.copyWith(
      dimensionPreset: value,
      width: dimensions.$1.toString(),
      height: dimensions.$2.toString(),
    );
  }

  Future<void> loadHistory() async {
    try {
      final history = await _repository.history();
      VideoGenerationRecord? active;
      for (final record in history) {
        if (record.job.isRunning) {
          active = record;
          break;
        }
      }
      state = state.copyWith(history: history, job: active?.job);
      if (active != null) _startPolling();
    } catch (error) {
      state = state.copyWith(error: readableErrorMessage(error));
    }
  }

  Future<void> create({String model = 'agnes-video-v2.0'}) async {
    final prompt = state.prompt.trim();
    if (state.isLoading || prompt.isEmpty) return;

    if (isAgnesVideo25OrLater(model)) {
      await _createModern(prompt: prompt);
      return;
    }
    await _createLegacy(prompt: prompt);
  }

  Future<void> _createModern({required String prompt}) async {
    const modes = {'text', 'keyframe', 'reference'};
    const sizes = {'720P', '1080P', '1K', '2K'};
    const aspectRatios = {'21:9', '16:9', '4:3', '1:1', '3:4', '9:16'};
    final mode = modes.contains(state.mode) ? state.mode : 'text';
    final seconds = int.tryParse(state.seconds.trim());
    final imageUrls = _parseUrls(state.imageUrls);
    final audioUrls = _parseUrls(state.audioUrls);
    final firstFrame = _nullableText(state.firstFrame);
    final lastFrame = _nullableText(state.lastFrame);
    final referenceVideoUrl = _nullableText(state.referenceVideoUrl);
    final hasReferenceMedia =
        imageUrls.isNotEmpty ||
        audioUrls.isNotEmpty ||
        referenceVideoUrl != null;

    if (!modes.contains(mode)) {
      _setValidationError('2.5 模式必须是 text、keyframe 或 reference。');
      return;
    }
    if (seconds == null || seconds < 4 || seconds > 12) {
      _setValidationError('seconds 必须是 4 到 12 之间的整数。');
      return;
    }
    if (!sizes.contains(state.size)) {
      _setValidationError('size 必须是 720P、1080P、1K 或 2K。');
      return;
    }
    if (!aspectRatios.contains(state.aspectRatio)) {
      _setValidationError('aspect_ratio 不是 Agnes Video 2.5 支持的画幅。');
      return;
    }
    if (imageUrls.length > 8 || audioUrls.length > 3) {
      _setValidationError('2.5 最多支持 8 张图片和 3 段音频参考。');
      return;
    }
    if (mode == 'keyframe' && firstFrame == null && lastFrame == null) {
      _setValidationError('keyframe 模式至少需要填写首帧或尾帧 URL。');
      return;
    }
    if (mode == 'keyframe' && hasReferenceMedia) {
      _setValidationError('keyframe 模式不能同时填写图片、音频或视频参考。');
      return;
    }
    if (mode == 'reference' && !hasReferenceMedia) {
      _setValidationError('reference 模式至少需要一种参考媒体。');
      return;
    }
    if (mode == 'reference' && (firstFrame != null || lastFrame != null)) {
      _setValidationError('reference 模式不能同时填写首帧或尾帧。');
      return;
    }

    final referenceVideos = referenceVideoUrl == null
        ? const <VideoReference>[]
        : [
            VideoReference(
              url: referenceVideoUrl,
              startSeconds:
                  double.tryParse(state.referenceVideoStartSeconds.trim()) ?? 0,
              requireAudio: state.referenceVideoRequireAudio,
            ),
          ];
    final options = VideoGenerationOptions(
      seed: int.tryParse(state.seed.trim()),
      mode: mode,
      seconds: seconds.toString(),
      size: state.size,
      aspectRatio: state.aspectRatio,
      firstFrame: firstFrame,
      lastFrame: lastFrame,
      imageUrls: imageUrls,
      audioUrls: audioUrls,
      referenceVideos: referenceVideos,
    );
    await _submit(prompt: prompt, options: options);
  }

  Future<void> _createLegacy({required String prompt}) async {
    final width = int.tryParse(state.width.trim());
    final height = int.tryParse(state.height.trim());
    final numFrames = int.tryParse(state.numFrames.trim());
    final frameRate = double.tryParse(state.frameRate.trim());
    if (width == null ||
        height == null ||
        width <= 0 ||
        height <= 0 ||
        numFrames == null ||
        frameRate == null) {
      _setValidationError('宽度、高度、帧数和帧率必须是有效数字。');
      return;
    }
    if (numFrames > 441 || numFrames < 1 || (numFrames - 1) % 8 != 0) {
      _setValidationError('num_frames 必须不超过 441，且满足 8n+1（如 81、121、241、441）。');
      return;
    }
    if (frameRate < 1 || frameRate > 60) {
      _setValidationError('frame_rate 必须在 1 到 60 之间。');
      return;
    }

    final options = VideoGenerationOptions(
      width: width,
      height: height,
      numFrames: numFrames,
      frameRate: frameRate,
      numInferenceSteps: int.tryParse(state.numInferenceSteps.trim()),
      seed: int.tryParse(state.seed.trim()),
      negativePrompt: state.negativePrompt.trim().isEmpty
          ? null
          : state.negativePrompt.trim(),
      imageUrl: state.imageUrl.trim().isEmpty ? null : state.imageUrl.trim(),
      mode: state.mode.isEmpty ? null : state.mode,
      keyframeUrls: _parseUrls(state.keyframeUrls),
    );
    await _submit(prompt: prompt, options: options);
  }

  Future<void> _submit({
    required String prompt,
    required VideoGenerationOptions options,
  }) async {
    state = state.copyWith(isLoading: true, error: null, job: null);
    try {
      final record = await _repository.create(prompt: prompt, options: options);
      state = state.copyWith(
        job: record.job,
        history: [record, ...state.history],
        isLoading: false,
      );
      if (_hasRunningJobs) _startPolling();
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }

  List<String> _parseUrls(String value) {
    return value
        .split(RegExp(r'[\n,]+'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  String? _nullableText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> poll() async {
    final job = state.job;
    if (job == null || state.isLoading || job.isCompleted || job.isFailed) {
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await _repository.poll(videoId: job.id);
      state = state.copyWith(
        job: updated.job,
        history: _replaceHistory(state.history, updated),
        isLoading: false,
      );
      if (_hasRunningJobs) {
        _startPolling();
      } else {
        _stopPolling();
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: readableErrorMessage(error),
      );
    }
  }

  void dismissError() => state = state.copyWith(error: null);

  void selectHistory(VideoGenerationRecord record) {
    state = state.copyWith(job: record.job, error: null);
    if (record.job.isRunning) _startPolling();
  }

  void _setValidationError(String message) {
    state = state.copyWith(error: message);
  }

  void _startPolling() {
    if (_pollTimer != null) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 8), (_) {
      if (!_hasRunningJobs) {
        _stopPolling();
        return;
      }
      _pollActiveJobs();
    });
  }

  Future<void> _pollActiveJobs() async {
    if (state.isLoading) return;
    final activeJobs = state.history
        .where((record) => record.job.isRunning)
        .toList();
    if (activeJobs.isEmpty) {
      _stopPolling();
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    String? lastError;
    for (final record in activeJobs) {
      try {
        final updated = await _repository.poll(videoId: record.videoId);
        final currentJob = state.job?.id == updated.videoId
            ? updated.job
            : state.job;
        state = state.copyWith(
          job: currentJob,
          history: _replaceHistory(state.history, updated),
        );
      } catch (error) {
        lastError = readableErrorMessage(error);
      }
    }
    state = state.copyWith(isLoading: false, error: lastError);
    if (!_hasRunningJobs) _stopPolling();
  }

  bool get _hasRunningJobs =>
      state.history.any((record) => record.job.isRunning);

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  List<VideoGenerationRecord> _replaceHistory(
    List<VideoGenerationRecord> history,
    VideoGenerationRecord updated,
  ) {
    return [
      updated,
      ...history.where((record) => record.videoId != updated.videoId),
    ];
  }
}
