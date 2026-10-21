import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/cache/app_media_cache.dart';

/// Headless video renderer with no playback controls.
class AppVideoPlayer extends StatelessWidget {
  const AppVideoPlayer({
    required this.controller,
    this.placeholderBuilder,
    this.errorBuilder,
    this.aspectRatio,
    super.key,
  });

  final AppVideoPlayerController controller;
  final WidgetBuilder? placeholderBuilder;
  final Widget Function(BuildContext context, Object? error)? errorBuilder;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.hasError) {
          return errorBuilder?.call(context, controller.error) ??
              const SizedBox(height: 220, child: Center(child: Text('视频加载失败')));
        }

        final realController = controller.realController;
        if (!value.isInitialized || realController == null) {
          return placeholderBuilder?.call(context) ??
              const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
        }

        final resolvedAspectRatio =
            aspectRatio ??
            (value.aspectRatio == 0 ? 16 / 9 : value.aspectRatio);
        return AspectRatio(
          aspectRatio: resolvedAspectRatio,
          child: VideoPlayer(realController),
        );
      },
    );
  }
}

/// Unified controller for FVP-backed playback with local file caching.
///
/// [CachedVideoPlayerPlus] starts a background cache download when the video
/// is not cached yet, while its underlying network controller can initialize
/// immediately. Once the file is cached, future initializations use the local
/// file directly.
class AppVideoPlayerController extends ChangeNotifier
    implements ValueListenable<VideoPlayerValue> {
  AppVideoPlayerController.networkUrl(
    this.remoteUri, {
    required this.cacheKey,
    required this.cache,
    this.httpHeaders = const <String, String>{},
    this.invalidateCacheIfOlderThan = const Duration(days: 7),
  });

  final Uri remoteUri;
  final String cacheKey;
  final AppMediaCache cache;
  final Map<String, String> httpHeaders;
  final Duration invalidateCacheIfOlderThan;

  VideoPlayerController? _realController;
  CachedVideoPlayerPlus? _cachedPlayer;
  Future<void>? _initialization;
  VideoPlayerValue _value = const VideoPlayerValue.uninitialized();
  Object? _error;
  int _operationToken = 0;
  bool _playbackCommandInFlight = false;
  String? _lastPlaybackCommand;
  DateTime? _lastPlaybackCommandAt;
  Duration? _pendingSeekPosition;
  Future<void>? _seekDrain;
  bool _completionGuarded = false;
  Future<void>? _pauseAtEndFuture;
  bool _disposed = false;

  @override
  VideoPlayerValue get value => _value;

  /// The active native controller used by [VideoPlayer].
  VideoPlayerController? get realController => _realController;

  Object? get error => _error;

  bool get isInitialized => _value.isInitialized;

  bool get isInitializing => _initialization != null;

  bool get isPlaying => _value.isPlaying;

  bool get isBuffering => _value.isBuffering;

  bool get isCompleted => _value.isCompleted;

  bool get isLooping => _value.isLooping;

  double get volume => _value.volume;

  Duration get position => _value.position;

  Duration get duration => _value.duration;

  double get aspectRatio => _value.aspectRatio;

  String? get errorDescription => _value.errorDescription;

  Future<void> initialize() {
    if (_disposed || isInitialized) return Future<void>.value();
    _error = null;
    return _initialization ??= _initializeInternal();
  }

  Future<void> _initializeInternal() async {
    final operationToken = ++_operationToken;
    try {
      await _initializeCachedPlayer();
    } on Object catch (error) {
      if (_disposed || operationToken != _operationToken) return;
      await _releaseRealController();
      _error = error;
      _value = VideoPlayerValue.erroneous(error.toString());
      notifyListeners();
    } finally {
      _initialization = null;
    }
  }

  Future<void> _initializeCachedPlayer() async {
    final cacheManager = await cache.videoCacheManager;
    final cachedPlayer = CachedVideoPlayerPlus.networkUrl(
      remoteUri,
      httpHeaders: httpHeaders,
      downloadHeaders: httpHeaders,
      cacheKey: cacheKey,
      invalidateCacheIfOlderThan: invalidateCacheIfOlderThan,
      cacheManager: cacheManager,
    );
    _cachedPlayer = cachedPlayer;
    try {
      await cachedPlayer.initialize();
      final controller = cachedPlayer.controller;
      if (!_attachRealController(controller)) {
        await cachedPlayer.dispose();
        _cachedPlayer = null;
        return;
      }
      if (!controller.value.isInitialized || controller.value.hasError) {
        final description =
            controller.value.errorDescription ??
            'Cached video player failed to initialize.';
        throw StateError(description);
      }
      _value = controller.value;
      notifyListeners();
    } on Object {
      await cachedPlayer.dispose();
      _cachedPlayer = null;
      _detachRealController();
      rethrow;
    }
  }

  bool _attachRealController(VideoPlayerController controller) {
    if (_disposed) return false;
    _realController = controller;
    controller.addListener(_handleRealControllerChanged);
    _value = controller.value;
    notifyListeners();
    return true;
  }

  void _detachRealController() {
    _realController?.removeListener(_handleRealControllerChanged);
    _realController = null;
  }

  Future<void> _releaseRealController() async {
    final realController = _realController;
    final cachedPlayer = _cachedPlayer;
    _detachRealController();
    _cachedPlayer = null;
    _value = const VideoPlayerValue.uninitialized();

    if (cachedPlayer != null) {
      await cachedPlayer.dispose();
    } else {
      await realController?.dispose();
    }
  }

  Future<void> play() async {
    final controller = _requireRealController();
    if (_playbackCommandInFlight) {
      _logPlaybackCommand('play skipped: command in flight');
      return;
    }
    if (_isDuplicatePlaybackCommand('play')) {
      _logPlaybackCommand('play skipped: duplicate command');
      return;
    }
    if (_value.isPlaying && !_value.isCompleted) {
      _logPlaybackCommand('play skipped: already playing');
      return;
    }

    _playbackCommandInFlight = true;
    _logPlaybackCommand('play');
    try {
      final pauseAtEnd = _pauseAtEndFuture;
      if (pauseAtEnd != null) {
        await pauseAtEnd;
      }
      if (_value.isCompleted || _completionGuarded) {
        // Some platform implementations can stop rendering at the end without
        // updating VideoPlayerValue.isCompleted. Always restart from the
        // beginning when the wrapper has normalized such an end state.
        _completionGuarded = false;
        await controller.seekTo(Duration.zero);
      }
      await controller.play();
    } finally {
      _playbackCommandInFlight = false;
    }
  }

  Future<void> pause() async {
    final controller = _requireRealController();
    if (_playbackCommandInFlight) {
      _logPlaybackCommand('pause skipped: command in flight');
      return;
    }
    if (_isDuplicatePlaybackCommand('pause')) {
      _logPlaybackCommand('pause skipped: duplicate command');
      return;
    }
    if (!_value.isPlaying) {
      _logPlaybackCommand('pause skipped: already paused');
      return;
    }

    _playbackCommandInFlight = true;
    _logPlaybackCommand('pause');
    try {
      await controller.pause();
    } finally {
      _playbackCommandInFlight = false;
    }
  }

  Future<void> seekTo(Duration position) async {
    final pauseAtEnd = _pauseAtEndFuture;
    if (pauseAtEnd != null) {
      await pauseAtEnd;
    }
    // A user seek is an explicit intent to leave the completed state. Clear
    // the guard before dispatching the seek so that the resulting position is
    // not mistaken for a stale update from the previous end-of-file event.
    _completionGuarded = false;
    _pendingSeekPosition = position;
    _logPlaybackCommand(
      _seekDrain == null
          ? 'seekTo requested: $position'
          : 'seekTo requested and coalesced: $position',
    );

    final drain = _seekDrain ??= _drainSeekRequests();
    await drain;
  }

  Future<void> _drainSeekRequests() async {
    try {
      while (!_disposed) {
        final position = _pendingSeekPosition;
        if (position == null) break;

        _pendingSeekPosition = null;
        final controller = _requireRealController();
        _logPlaybackCommand('seekTo executing: $position');
        await controller.seekTo(position);

        // A late EOF callback may have re-established the completion guard
        // while this explicit seek was being completed. The requested seek is
        // authoritative, so publish its position before accepting future
        // native callbacks.
        if (!_disposed && position < controller.value.duration) {
          _completionGuarded = false;
          _value = controller.value;
          notifyListeners();
        }
      }
    } finally {
      _seekDrain = null;
      if (!_disposed && _realController != null) {
        // Re-evaluate a seek-to-end after the explicit seek queue is gone; it
        // should use the same normalized completion path as natural EOF.
        _handleRealControllerChanged();
      }
    }
  }

  Future<void> setLooping(bool looping) =>
      _requireRealController().setLooping(looping);

  Future<void> setVolume(double volume) =>
      _requireRealController().setVolume(volume);

  Future<void> setPlaybackSpeed(double speed) =>
      _requireRealController().setPlaybackSpeed(speed);

  VideoPlayerController _requireRealController() {
    final controller = _realController;
    if (controller == null || !isInitialized) {
      throw StateError('AppVideoPlayerController is not initialized.');
    }
    return controller;
  }

  void _handleRealControllerChanged() {
    final controller = _realController;
    if (_disposed || controller == null) return;

    final previousValue = _value;
    final controllerValue = controller.value;
    final explicitSeekInFlight = _seekDrain != null;
    final reachedEnd =
        controllerValue.isInitialized &&
        controllerValue.duration > Duration.zero &&
        !controllerValue.isLooping &&
        controllerValue.position >= controllerValue.duration;

    if (!explicitSeekInFlight &&
        (reachedEnd ||
            (controllerValue.isCompleted && !controllerValue.isLooping))) {
      _completionGuarded = true;
      // Do not expose a playing-at-end state. Apart from making the controls
      // truthful, this also prevents a late position callback from moving the
      // slider back to the position of a seek that preceded completion.
      _value = controllerValue.copyWith(
        position: controllerValue.duration,
        isPlaying: false,
        isCompleted: true,
      );
      if (controllerValue.isPlaying) {
        unawaited(_pauseAtEnd(controller));
      }
    } else if (_completionGuarded &&
        controllerValue.isInitialized &&
        controllerValue.position < controllerValue.duration) {
      // A seek that was already in flight can report its old position after
      // the native player reached EOF. Keep the normalized end state until an
      // explicit play or seek command clears the guard.
      _value = previousValue;
    } else {
      _value = controllerValue;
    }
    if (previousValue.isPlaying != _value.isPlaying ||
        previousValue.isBuffering != _value.isBuffering ||
        previousValue.isCompleted != _value.isCompleted) {
      debugPrint(
        '[VideoPlayback] state changed: '
        'playing=${previousValue.isPlaying}->${_value.isPlaying}, '
        'buffering=${previousValue.isBuffering}->${_value.isBuffering}, '
        'completed=${previousValue.isCompleted}->${_value.isCompleted}, '
        'position=${_value.position}',
      );
    }
    notifyListeners();
  }

  Future<void> _pauseAtEnd(VideoPlayerController controller) {
    return _pauseAtEndFuture ??= _pauseAtEndInternal(controller)
        .whenComplete(() => _pauseAtEndFuture = null);
  }

  Future<void> _pauseAtEndInternal(VideoPlayerController controller) async {
    try {
      await controller.pause();
      if (!_disposed &&
          identical(_realController, controller) &&
          _completionGuarded) {
        // Reinforce the final frame after pause. This also wins over a stale
        // asynchronous seek that some backends may finish after EOF.
        await controller.seekTo(_value.duration);
      }
    } catch (_) {
      // The controller may be released while the native end event is in flight.
    }
  }

  void _logPlaybackCommand(String command) {
    debugPrint('[VideoPlayback] $command; cacheKey=$cacheKey');
  }

  bool _isDuplicatePlaybackCommand(String command) {
    final now = DateTime.now();
    final isDuplicate =
        _lastPlaybackCommand == command &&
        _lastPlaybackCommandAt != null &&
        now.difference(_lastPlaybackCommandAt!) <
            const Duration(milliseconds: 180);
    _lastPlaybackCommand = command;
    _lastPlaybackCommandAt = now;
    return isDuplicate;
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _operationToken++;
    _initialization = null;
    final releaseFuture = _releaseRealController();
    super.dispose();
    unawaited(releaseFuture);
  }
}
