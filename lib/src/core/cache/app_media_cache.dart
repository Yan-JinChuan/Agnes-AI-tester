import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config_provider.dart';
import 'cache_manager_factory.dart';

part 'app_media_cache.g.dart';

@riverpod
AppMediaCache appMediaCache(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final cache = AppMediaCache(configuredDirectory: config.cacheDirectory);
  ref.onDispose(cache.dispose);
  return cache;
}

/// 供图像和视频功能使用的统一媒体缓存入口。
///
/// 配置的目录仅作为缓存根目录。各类媒体文件分别存储在各自的子目录中，
/// 这样既便于检查目录内容，也支持将整个目录作为一个整体进行移动或备份。
class AppMediaCache {
  AppMediaCache({required this.configuredDirectory});

  final String configuredDirectory;

  Future<CacheManager>? _imageManager;
  Future<CacheManager>? _videoManager;

  bool get supportsCustomDirectory => cacheManagerSupportsCustomDirectory;

  Future<CacheManager> get imageCacheManager => _imageManager ??=
      createCacheManager(configuredDirectory, category: 'images');

  Future<CacheManager> get videoCacheManager => _videoManager ??=
      createCacheManager(configuredDirectory, category: 'videos');

  Future<Uint8List> getImageBytes(String url) async {
    final manager = await imageCacheManager;
    final file = await manager.getSingleFile(url, key: 'image:$url');
    return Uint8List.fromList(await file.readAsBytes());
  }

  Future<void> putImageBytes(String cacheKey, Uint8List bytes) async {
    final manager = await imageCacheManager;
    await manager.putFile(
      'generated-image:$cacheKey',
      bytes,
      key: 'generated-image:$cacheKey',
      fileExtension: 'bin',
    );
  }

  Future<void> clear() async {
    final managers = <Future<CacheManager>>[];
    if (_imageManager != null) managers.add(imageCacheManager);
    if (_videoManager != null) managers.add(videoCacheManager);
    for (final managerFuture in managers) {
      await (await managerFuture).emptyCache();
    }
  }

  Future<void> dispose() async {
    final managers = <Future<CacheManager>>[];
    if (_imageManager != null) managers.add(imageCacheManager);
    if (_videoManager != null) managers.add(videoCacheManager);
    for (final managerFuture in managers) {
      try {
        await (await managerFuture).dispose();
      } on Object {
        // A failed cache initialization should not prevent provider disposal.
      }
    }
  }
}
