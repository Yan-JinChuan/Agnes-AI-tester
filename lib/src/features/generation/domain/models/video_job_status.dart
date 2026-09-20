/// 由视频生成领域公开的标准化生命周期状态。
enum VideoJobStatus {
  queued,
  processing,
  completed,
  failed,
  cancelled,
  unknown;

  /// 将 API 或持久化存储的状态值转换为领域状态。
  static VideoJobStatus fromWireValue(Object? value) {
    final normalized = value?.toString().trim().toLowerCase();
    return switch (normalized) {
      null || '' || 'queued' || 'pending' || 'created' => queued,
      'in_progress' || 'processing' || 'running' => processing,
      'completed' || 'succeeded' || 'success' || 'done' => completed,
      'failed' || 'error' => failed,
      'cancelled' || 'canceled' => cancelled,
      _ => unknown,
    };
  }

  /// 在持久化状态或通过网络传输状态时所使用的固定值。
  String get wireValue => switch (this) {
    queued => 'queued',
    processing => 'processing',
    completed => 'completed',
    failed => 'failed',
    cancelled => 'cancelled',
    unknown => 'unknown',
  };

  bool get isCompleted => this == completed;

  bool get isFailed => this == failed || this == cancelled;

  bool get isRunning => !isCompleted && !isFailed;
}
