import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/core/cache/cache_usage.dart';
import 'package:agnes_ai_tester/src/core/cache/media_cache_repository.dart';
import 'package:agnes_ai_tester/src/core/cache/media_cache_repository_provider.dart';
import 'package:agnes_ai_tester/src/features/settings/presentation/viewmodels/settings_view_model.dart';

void main() {
  test(
    'clearCache refreshes usage after the repository clears storage',
    () async {
      final repository = _FakeMediaCacheRepository(
        usage: const CacheUsage(imageBytes: 3, videoBytes: 5),
      );
      final container = ProviderContainer(
        overrides: [mediaCacheRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final viewModel = container.read(settingsViewModelProvider.notifier);
      await viewModel.loadCacheUsage();

      expect(
        container.read(settingsViewModelProvider).cacheUsage?.totalBytes,
        8,
      );

      final cleared = await viewModel.clearCache();

      expect(cleared, isTrue);
      expect(repository.clearCalled, isTrue);
      expect(
        container.read(settingsViewModelProvider).cacheUsage?.totalBytes,
        0,
      );
      expect(
        container.read(settingsViewModelProvider).isClearingCache,
        isFalse,
      );
    },
  );
}

class _FakeMediaCacheRepository implements MediaCacheRepository {
  _FakeMediaCacheRepository({required this.usage});

  CacheUsage usage;
  bool clearCalled = false;

  @override
  Future<void> clear() async {
    clearCalled = true;
    usage = CacheUsage.empty;
  }

  @override
  Future<CacheUsage> getUsage() async => usage;
}
