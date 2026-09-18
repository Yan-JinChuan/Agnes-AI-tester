import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<CacheManager> createCacheManager(
  String configuredDirectory, {
  required String category,
}) async {
  return CacheManager(Config('agnes_media_cache_$category'));
}

bool get supportsCustomDirectory => false;
