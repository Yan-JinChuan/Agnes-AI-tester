import 'package:flutter/material.dart';

import '../../../../core/cache/app_media_cache.dart';
import '../../domain/models/video_generation_record.dart';
import '../extensions/video_job_status_ui_extension.dart';
import 'cached_video_player.dart';

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
    final statusColor = job.status.resolveColor(context);
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
                    job.status.displayLabel,
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

String _formatFrameRate(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();
}
