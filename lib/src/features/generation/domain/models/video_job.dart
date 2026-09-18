class VideoJob {
  const VideoJob({
    required this.id,
    required this.status,
    required this.progress,
    this.url,
    this.error,
    this.actualSize,
    this.seconds,
    this.metadataMessage,
  });

  final String id;
  final String status;
  final int progress;
  final String? url;
  final String? error;
  final String? actualSize;
  final double? seconds;
  final String? metadataMessage;

  bool get isCompleted => {
    'completed',
    'succeeded',
    'success',
    'done',
  }.contains(status.toLowerCase());

  bool get isFailed => {
    'failed',
    'error',
    'cancelled',
    'canceled',
  }.contains(status.toLowerCase());

  bool get isRunning => !isCompleted && !isFailed;
}
