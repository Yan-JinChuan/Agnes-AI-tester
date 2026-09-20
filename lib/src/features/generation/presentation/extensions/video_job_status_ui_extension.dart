import 'package:flutter/material.dart';

import '../../domain/models/video_job_status.dart';

extension VideoJobStatusUiX on VideoJobStatus {
  String get displayLabel => switch (this) {
    VideoJobStatus.completed => '已完成',
    VideoJobStatus.failed || VideoJobStatus.cancelled => '失败',
    VideoJobStatus.processing => '生成中',
    VideoJobStatus.queued || VideoJobStatus.unknown => '排队中',
  };

  Color resolveColor(BuildContext context) => switch (this) {
    VideoJobStatus.completed => Colors.green.shade700,
    VideoJobStatus.failed ||
    VideoJobStatus.cancelled => Theme.of(context).colorScheme.error,
    VideoJobStatus.processing ||
    VideoJobStatus.queued ||
    VideoJobStatus.unknown => Theme.of(context).colorScheme.primary,
  };
}
