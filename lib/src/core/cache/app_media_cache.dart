import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config_provider.dart';
import 'cache_manager_factory.dart';

part 'app_media_cache.g.dart';

@Riverpod(keepAlive: true)
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

  // ================= 1. 新增：供 fvp 专用的视频缓存路径 =================
  /// fvp 播放内核专用的分片与流式缓存目录。
  /// 存储在根目录下的 `videos/fvp_cache` 或 `fvp_videos` 子目录中。
  String get fvpVideoCachePath => path.join(configuredDirectory, 'videos', 'fvp_cache');

  /// 确保该目录在磁盘上真实存在，返回绝对路径
  Future<String> getOrCreateFvpCachePath() async {
    final dir = Directory(fvpVideoCachePath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
  // =====================================================================

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

  /// 统一清空所有缓存（包含图片、CacheManager 和 fvp 缓存）
  Future<void> clear() async {
    // 1. 清理 CacheManager 管理的图片与普通视频
    final managers = <Future<CacheManager>>[];
    if (_imageManager != null) managers.add(imageCacheManager);
    if (_videoManager != null) managers.add(videoCacheManager);
    for (final managerFuture in managers) {
      await (await managerFuture).emptyCache();
    }

    // 2. 新增：同步清空 fvp 的本地视频缓存目录
    try {
      final fvpDir = Directory(fvpVideoCachePath);
      if (await fvpDir.exists()) {
        await fvpDir.delete(recursive: true);
        await fvpDir.create(recursive: true); // 删完重建空目录
      }
    } catch (e) {
      // 避免个别正在占用的文件导致清空逻辑完全崩溃
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
