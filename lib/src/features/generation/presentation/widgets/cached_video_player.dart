import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/cache/app_media_cache.dart';

class CachedVideoPlayer extends StatefulWidget {
  const CachedVideoPlayer({
    required this.url,
    required this.cacheKey,
    required this.cache,
    super.key,
  });

  final String url;
  final String cacheKey;
  final AppMediaCache cache;

  @override
  State<CachedVideoPlayer> createState() => _CachedVideoPlayerState();
}

class _CachedVideoPlayerState extends State<CachedVideoPlayer> {
  CachedVideoPlayerPlus? _player;
  Object? _error;
  VideoPlayerController? _listeningController;
  bool _holdWindowsPlayerAtEnd = false;
  bool _pauseAfterEndPending = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant CachedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url || oldWidget.cache != widget.cache) {
      _disposePlayer();
      _error = null;
      _initialize();
    }
  }

  Future<void> _initialize() async {
    try {
      final cacheManager = await widget.cache.videoCacheManager;
      final player = CachedVideoPlayerPlus.networkUrl(
        Uri.parse(widget.url),
        cacheKey: widget.cacheKey,
        invalidateCacheIfOlderThan: const Duration(days: 7),
        cacheManager: cacheManager,
      );
      _player = player;
      await player.initialize();
      if (!mounted || _player != player) {
        await player.dispose();
        return;
      }
      _listeningController = player.controller;
      _listeningController!.addListener(_handleControllerValueChanged);
      setState(() {});
    } catch (error) {
      _disposePlayer();
      if (mounted) setState(() => _error = error);
    }
  }

  void _disposePlayer() {
    final listeningController = _listeningController;
    _listeningController = null;
    listeningController?.removeListener(_handleControllerValueChanged);

    final player = _player;
    _player = null;
    _holdWindowsPlayerAtEnd = false;
    _pauseAfterEndPending = false;
    if (player != null) unawaited(player.dispose());
  }

  void _handleControllerValueChanged() {
    final controller = _listeningController;
    if (controller == null || defaultTargetPlatform != TargetPlatform.windows) {
      return;
    }

    final value = controller.value;
    if (value.isCompleted) {
      _holdWindowsPlayerAtEnd = true;
      return;
    }

    if (_holdWindowsPlayerAtEnd && value.isPlaying) {
      unawaited(_pauseWindowsAutoReplay(controller));
    }
  }

  Future<void> _pauseWindowsAutoReplay(VideoPlayerController controller) async {
    if (_pauseAfterEndPending) return;
    _pauseAfterEndPending = true;
    try {
      await controller.pause();
    } catch (_) {
      // The player can be disposed while the native end event is in flight.
    } finally {
      _pauseAfterEndPending = false;
    }
  }

  Future<void> _togglePlayback(VideoPlayerController controller) async {
    final value = controller.value;
    _holdWindowsPlayerAtEnd = false;
    _pauseAfterEndPending = false;
    try {
      if (value.isCompleted) {
        await controller.seekTo(Duration.zero);
        await controller.play();
      } else if (!value.isPlaying) {
        await controller.play();
      } else {
        await controller.pause();
      }
    } catch (_) {
      // The player may be disposed while the user is interacting with it.
    }
  }

  void _seek(VideoPlayerController controller, double milliseconds) {
    _holdWindowsPlayerAtEnd = false;
    _pauseAfterEndPending = false;
    unawaited(
      controller
          .seekTo(Duration(milliseconds: milliseconds.round()))
          .catchError((_) {}),
    );
  }

  @override
  void dispose() {
    _disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = _player;
    if (_error != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFFF0F0F5),
        child: const Text('视频加载失败，请检查视频地址或平台播放能力。'),
      );
    }
    if (player == null || !player.isInitialized) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final aspectRatio = player.controller.value.aspectRatio == 0
        ? 16 / 9
        : player.controller.value.aspectRatio;
    return Column(
      children: [
        RepaintBoundary(
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: VideoPlayer(player.controller),
          ),
        ),
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: player.controller,
          builder: (context, value, child) {
            final duration = value.duration.inMilliseconds.toDouble();
            final position = value.position.inMilliseconds
                .toDouble()
                .clamp(0.0, duration)
                .toDouble();
            return Row(
              children: [
                IconButton(
                  tooltip: value.isPlaying ? '暂停' : '播放',
                  onPressed: () => _togglePlayback(player.controller),
                  icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                Expanded(
                  child: Slider(
                    value: duration > 0 ? position : 0,
                    min: 0,
                    max: duration > 0 ? duration : 1,
                    onChanged: duration > 0
                        ? (next) => _seek(player.controller, next)
                        : null,
                  ),
                ),
                Text(
                  '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
                const SizedBox(width: 8),
              ],
            );
          },
        ),
      ],
    );
  }
}

String _formatDuration(Duration value) {
  final minutes = value.inMinutes.toString().padLeft(2, '0');
  final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
