import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/core/cache/app_media_cache.dart';
import 'package:agnes_ai_tester/src/shared/widgets/video/app_video_player.dart';

void main() {
  test('uses a 30-day default video cache freshness window', () {
    final controller = AppVideoPlayerController.networkUrl(
      Uri.parse('https://example.com/video.mp4'),
      cacheKey: 'video-cache-test',
      cache: AppMediaCache(configuredDirectory: 'test-cache'),
    );
    addTearDown(controller.dispose);

    expect(controller.invalidateCacheIfOlderThan, const Duration(days: 30));
  });
}
