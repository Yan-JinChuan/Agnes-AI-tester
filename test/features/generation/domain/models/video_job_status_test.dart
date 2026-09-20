import 'package:agnes_ai_tester/src/features/generation/domain/models/video_job_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoJobStatus', () {
    test('normalizes API aliases to domain statuses', () {
      expect(VideoJobStatus.fromWireValue('done'), VideoJobStatus.completed);
      expect(
        VideoJobStatus.fromWireValue('in_progress'),
        VideoJobStatus.processing,
      );
      expect(
        VideoJobStatus.fromWireValue('canceled'),
        VideoJobStatus.cancelled,
      );
      expect(VideoJobStatus.fromWireValue(null), VideoJobStatus.queued);
      expect(
        VideoJobStatus.fromWireValue('unexpected'),
        VideoJobStatus.unknown,
      );
    });

    test('exposes stable persistence values and lifecycle flags', () {
      expect(VideoJobStatus.completed.wireValue, 'completed');
      expect(VideoJobStatus.cancelled.isFailed, isTrue);
      expect(VideoJobStatus.processing.isRunning, isTrue);
      expect(VideoJobStatus.completed.isRunning, isFalse);
    });
  });
}
