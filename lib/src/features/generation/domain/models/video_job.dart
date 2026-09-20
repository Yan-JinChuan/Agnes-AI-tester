import 'video_job_status.dart';

class VideoJob({
  required final String id,
  required final VideoJobStatus status,
  required final int progress,
  final String? url,
  final String? error,
  final String? actualSize,
  final double? seconds,
  final String? metadataMessage,
}) {
  bool get isCompleted => status.isCompleted;

  bool get isFailed => status.isFailed;

  bool get isRunning => status.isRunning;
}
