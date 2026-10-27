import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

import 'package:agnes_ai_tester/src/core/cache/app_media_cache.dart';
import 'package:agnes_ai_tester/src/core/cache/cache_deletion_policy.dart';

void main() {
  late Directory temporaryRoot;

  setUp(() async {
    temporaryRoot = await Directory.systemTemp.createTemp('agnes-cache-test-');
  });

  tearDown(() async {
    if (await temporaryRoot.exists()) {
      await temporaryRoot.delete(recursive: true);
    }
  });

  test('reports image, video and total byte usage', () async {
    await _writeBytes(path.join(temporaryRoot.path, 'images', 'image.bin'), 3);
    await _writeBytes(path.join(temporaryRoot.path, 'videos', 'video.bin'), 5);
    await _writeBytes(
      path.join(temporaryRoot.path, 'videos', 'nested', 'segment.bin'),
      7,
    );

    final usage = await AppMediaCache(configuredDirectory: temporaryRoot.path)
        .getUsage();

    expect(usage.imageBytes, 3);
    expect(usage.videoBytes, 12);
    expect(usage.totalBytes, 15);
  });

  test(
    'clear removes cache files even when managers were not initialized',
    () async {
      await _writeBytes(
        path.join(temporaryRoot.path, 'images', 'image.bin'),
        3,
      );
      await _writeBytes(
        path.join(temporaryRoot.path, 'videos', 'segment.bin'),
        7,
      );

      final cache = AppMediaCache(configuredDirectory: temporaryRoot.path);
      await cache.clear();

      final usage = await cache.getUsage();
      expect(usage.totalBytes, 0);
    },
  );

  test(
    'clear skips a cache file that is still locked by the video player',
    () async {
      if (!Platform.isWindows) return;

      final filePath = path.join(temporaryRoot.path, 'videos', 'playing.mp4');
      await _writeBytes(filePath, 11);
      final lockedFile = await File(filePath).open();
      try {
        final cache = AppMediaCache(configuredDirectory: temporaryRoot.path);

        await cache.clear();

        final usage = await cache.getUsage();
        expect(usage.videoBytes, 11);
      } finally {
        await lockedFile.close();
      }
    },
  );

  test('accepts expected cache deletion results across native platforms', () {
    for (final errorCode in <int>[32, 33, 39, 66, 145]) {
      final error = FileSystemException(
        'Cache deletion can be retried',
        path.join(temporaryRoot.path, 'videos'),
        OSError('Cache deletion can be retried', errorCode),
      );

      expect(isExpectedCacheDeletionFailure(error), isTrue);
    }

    final unexpectedError = FileSystemException(
      'Permission denied',
      path.join(temporaryRoot.path, 'videos'),
      const OSError('Permission denied', 13),
    );
    expect(isExpectedCacheDeletionFailure(unexpectedError), isFalse);
  });
}

Future<void> _writeBytes(String filePath, int length) async {
  final file = File(filePath);
  await file.parent.create(recursive: true);
  await file.writeAsBytes(List<int>.filled(length, 1));
}
