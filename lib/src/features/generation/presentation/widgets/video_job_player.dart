import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/cache/app_media_cache.dart';
import '../../../../shared/widgets/video/app_video_player.dart';

class VideoJobPlayer extends ConsumerStatefulWidget {
  const VideoJobPlayer({required this.url, required this.cacheKey, super.key});

  final String url;
  final String cacheKey;

  @override
  ConsumerState<VideoJobPlayer> createState() => _VideoJobPlayerState();
}

class _VideoJobPlayerState extends ConsumerState<VideoJobPlayer> {
  late AppVideoPlayerController _controller;
  bool _playbackCommandInFlight = false;
  double? _sliderPreviewMilliseconds;

  @override
  void initState() {
    super.initState();
    _createController();
  }

  @override
  void didUpdateWidget(covariant VideoJobPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url || oldWidget.cacheKey != widget.cacheKey) {
      _controller.dispose();
      _createController();
    }
  }

  void _createController() {
    _playbackCommandInFlight = false;
    debugPrint(
      '[VideoPlayback] create controller: '
      'cacheKey=${widget.cacheKey}; url=${widget.url}',
    );
    _controller = AppVideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      cacheKey: widget.cacheKey,
      cache: ref.read(appMediaCacheProvider),
    );
    unawaited(_controller.initialize());
  }

  Future<void> _togglePlayback() async {
    if (_playbackCommandInFlight) {
      debugPrint('[VideoPlayback] toggle skipped: command in flight');
      return;
    }

    _playbackCommandInFlight = true;
    final value = _controller.value;
    debugPrint(
      '[VideoPlayback] toggle requested: '
      'playing=${value.isPlaying}, completed=${value.isCompleted}',
    );
    try {
      if (value.isPlaying) {
        await _controller.pause();
      } else {
        await _controller.play();
      }
    } catch (error) {
      // The controller can be disposed while the user is interacting with it.
      debugPrint('[VideoPlayback] toggle failed: $error');
    } finally {
      _playbackCommandInFlight = false;
    }
  }

  void _previewSeek(double milliseconds) {
    if (!mounted) return;
    setState(() => _sliderPreviewMilliseconds = milliseconds);
  }

  void _seek(double milliseconds) {
    if (mounted) {
      setState(() => _sliderPreviewMilliseconds = null);
    }
    final position = Duration(milliseconds: milliseconds.round());
    debugPrint('[VideoPlayback] slider seek requested: $position');
    unawaited(
      _controller.seekTo(position).catchError((error) {
        debugPrint('[VideoPlayback] slider seek failed: $error');
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepaintBoundary(child: AppVideoPlayer(controller: _controller)),
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller,
          builder: (context, value, child) {
            final duration = value.duration.inMilliseconds.toDouble();
            final position = value.position.inMilliseconds
                .toDouble()
                .clamp(0.0, duration)
                .toDouble();
            final sliderPosition = (_sliderPreviewMilliseconds ?? position)
                .clamp(0.0, duration)
                .toDouble();
            return Row(
              children: [
                IconButton(
                  tooltip: value.isPlaying ? '暂停' : '播放',
                  onPressed: value.isInitialized ? _togglePlayback : null,
                  icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                Expanded(
                  child: Slider(
                    value: duration > 0 ? sliderPosition : 0,
                    min: 0,
                    max: duration > 0 ? duration : 1,
                    onChanged: duration > 0 ? _previewSeek : null,
                    onChangeEnd: duration > 0 ? _seek : null,
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
