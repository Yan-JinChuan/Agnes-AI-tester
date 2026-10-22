import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_media_cache.dart';
import 'media_cache_repository.dart';

/// 通过最小仓库契约暴露具体的媒体缓存实现。
final mediaCacheRepositoryProvider = Provider<MediaCacheRepository>(
  (ref) => ref.watch(appMediaCacheProvider),
);
