import 'package:agnes_ai_tester/src/features/generation/domain/models/video_job_status.dart';
import 'package:agnes_ai_tester/src/features/generation/presentation/extensions/video_job_status_ui_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('translates video statuses into presentation labels', () {
    expect(VideoJobStatus.completed.displayLabel, '已完成');
    expect(VideoJobStatus.failed.displayLabel, '失败');
    expect(VideoJobStatus.processing.displayLabel, '生成中');
    expect(VideoJobStatus.queued.displayLabel, '排队中');
  });
}
