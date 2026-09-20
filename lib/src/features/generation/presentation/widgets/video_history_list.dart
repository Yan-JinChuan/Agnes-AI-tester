import 'package:flutter/material.dart';

import '../../domain/models/video_generation_record.dart';
import '../extensions/video_job_status_ui_extension.dart';

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
            final color = record.status.resolveColor(context);
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
                              '${record.status.displayLabel} · '
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

String _formatVideoDate(DateTime value) {
  final local = value.toLocal();
  final date =
      '${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  final time =
      '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}
