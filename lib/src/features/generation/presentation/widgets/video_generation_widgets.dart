import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:agnes_ai_tester/src/core/cache/app_media_cache.dart';

import '../../domain/models/video_generation_record.dart';

class VideoJobCard extends StatelessWidget {
  const VideoJobCard({
    required this.record,
    required this.cache,
    required this.isLoading,
    required this.onPoll,
    super.key,
  });

  final VideoGenerationRecord record;
  final AppMediaCache cache;
  final bool isLoading;
  final VoidCallback onPoll;

  @override
  Widget build(BuildContext context) {
    final job = record.job;
    final statusColor = job.isFailed
        ? Theme.of(context).colorScheme.error
        : job.isCompleted
        ? Colors.green.shade700
        : Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '视频任务',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
                Chip(
                  label: Text(
                    _videoStatusLabel(job.status),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: statusColor.withValues(alpha: 0.10),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(record.prompt, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 12),
            Text(
              '请求参数：${record.options.width} × ${record.options.height} · '
              '${record.options.numFrames} 帧 · ${_formatFrameRate(record.options.frameRate)} fps',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            if (job.actualSize != null || job.seconds != null) ...[
              const SizedBox(height: 5),
              Text(
                '实际输出：${job.actualSize ?? '服务端未返回尺寸'}'
                '${job.seconds == null ? '' : ' · ${job.seconds!.toStringAsFixed(2)} 秒'}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
            if (job.metadataMessage != null &&
                job.metadataMessage!.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                job.metadataMessage!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
            const SizedBox(height: 12),
            LinearProgressIndicator(value: job.progress / 100),
            const SizedBox(height: 10),
            Text('进度：${job.progress}%'),
            const SizedBox(height: 5),
            SelectableText(
              'video_id：${job.id}',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            ),
            if (job.error != null && job.error!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(job.error!, style: TextStyle(color: statusColor)),
            ],
            if (job.url != null && job.url!.isNotEmpty) ...[
              const SizedBox(height: 16),
              CachedVideoPlayer(url: job.url!, cacheKey: job.id, cache: cache),
              const SizedBox(height: 12),
              const Text('视频地址', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              SelectableText(job.url!),
            ],
            if (job.isRunning) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: isLoading ? null : onPoll,
                    icon: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(isLoading ? '查询中…' : '立即查询'),
                  ),
                  Text(
                    isLoading ? '正在自动更新状态' : '每 8 秒自动查询一次',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class VideoHistoryList extends StatelessWidget {
  const VideoHistoryList({
    required this.history,
    required this.onSelect,
    super.key,
  });

  final List<VideoGenerationRecord> history;
  final ValueChanged<VideoGenerationRecord> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '视频历史',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final record = history[index];
            final color = record.job.isFailed
                ? Theme.of(context).colorScheme.error
                : record.job.isCompleted
                ? Colors.green.shade700
                : Theme.of(context).colorScheme.primary;
            return Card(
              child: InkWell(
                onTap: () => onSelect(record),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(Icons.movie_outlined, color: color),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.prompt.isEmpty ? '视频任务' : record.prompt,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${_videoStatusLabel(record.status)} · '
                              '${record.progress}% · '
                              '${record.options.width}×${record.options.height} · '
                              '${_formatVideoDate(record.updatedAt)}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

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

String _videoStatusLabel(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
    case 'succeeded':
    case 'success':
    case 'done':
      return '已完成';
    case 'failed':
    case 'error':
    case 'cancelled':
    case 'canceled':
      return '失败';
    case 'in_progress':
    case 'processing':
    case 'running':
      return '生成中';
    default:
      return '排队中';
  }
}

String _formatVideoDate(DateTime value) {
  final local = value.toLocal();
  final date =
      '${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  final time =
      '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}

String _formatDuration(Duration value) {
  final minutes = value.inMinutes.toString().padLeft(2, '0');
  final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

String _formatFrameRate(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();
}
