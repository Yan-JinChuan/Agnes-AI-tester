import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config_provider.dart';
import 'cache_manager_factory.dart';
import 'cache_deletion_policy.dart';
import 'cache_usage.dart';
import 'media_cache_repository.dart';

part 'app_media_cache.g.dart';

@Riverpod(keepAlive: true)
/// 根据运行时配置创建全局媒体缓存服务。
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
class AppMediaCache implements MediaCacheRepository {
  /// 使用用户配置的目录创建媒体缓存；配置为空时使用应用默认缓存目录。
  AppMediaCache({required this.configuredDirectory});

  /// 用户选择的缓存根目录；为空时使用平台默认目录。
  final String configuredDirectory;

  Future<CacheManager>? _imageManager;
  Future<CacheManager>? _videoManager;

  /// 当前平台是否支持使用用户指定的缓存目录。
  bool get supportsCustomDirectory => cacheManagerSupportsCustomDirectory;

  /// 获取图片缓存管理器。
  Future<CacheManager> get imageCacheManager => _imageManager ??=
      createCacheManager(configuredDirectory, category: 'images');

  /// 获取普通视频缓存管理器。
  Future<CacheManager> get videoCacheManager => _videoManager ??=
      createCacheManager(configuredDirectory, category: 'videos');

  /// 读取指定网络图片并返回其字节内容。
  Future<Uint8List> getImageBytes(String url) async {
    final manager = await imageCacheManager;
    final file = await manager.getSingleFile(url, key: 'image:$url');
    return Uint8List.fromList(await file.readAsBytes());
  }

  /// 将生成的图片字节写入图片缓存。
  Future<void> putImageBytes(String cacheKey, Uint8List bytes) async {
    final manager = await imageCacheManager;
    await manager.putFile(
      'generated-image:$cacheKey',
      bytes,
      key: 'generated-image:$cacheKey',
      fileExtension: 'bin',
    );
  }

  /// 读取当前所有受管理媒体缓存的磁盘占用。
  ///
  /// 不存在的目录按空目录处理，使设置页在首次下载前也能正常显示。
  @override
  Future<CacheUsage> getUsage() async {
    final rootPath = await _resolveCacheRootPath();
    final imagePath = path.join(rootPath, 'images');
    final videoPath = path.join(rootPath, 'videos');

    final videoBytes = await _directorySize(Directory(videoPath));
    final imageBytes = await _directorySize(Directory(imagePath));

    return CacheUsage(imageBytes: imageBytes, videoBytes: videoBytes);
  }

  /// 清理所有图片和视频缓存文件。
  @override
  Future<void> clear() async {
    // 即使当前进程尚未播放过媒体，也要初始化管理器并清理旧进程遗留的文件。
    for (final managerFuture in <Future<CacheManager>>[
      imageCacheManager,
      videoCacheManager,
    ]) {
      try {
        await (await managerFuture).emptyCache();
      } on FileSystemException catch (error) {
        // 播放器占用文件或目录并发变化都不应阻断其余缓存清理。
        if (!isExpectedCacheDeletionFailure(error)) rethrow;
      }
    }

    // emptyCache 只知道缓存索引中的文件；删除并重建目录才能同时清理
    // 下载中断留下的孤立文件。
    final rootPath = await _resolveCacheRootPath();
    await _clearDirectory(path.join(rootPath, 'images'));
    await _clearDirectory(path.join(rootPath, 'videos'));
  }

  Future<String> _resolveCacheRootPath() async {
    final configuredPath = configuredDirectory.trim();
    if (configuredPath.isNotEmpty) return path.normalize(configuredPath);

    return path.join(
      (await getApplicationCacheDirectory()).path,
      'agnes_ai_tester',
    );
  }

  Future<int> _directorySize(Directory directory) async {
    if (!await directory.exists()) return 0;

    var totalBytes = 0;
    await for (final entity in directory.list(followLinks: false)) {
      if (entity is File) {
        totalBytes += await entity.length();
      } else if (entity is Directory) {
        totalBytes += await _directorySize(entity);
      }
    }
    return totalBytes;
  }

  Future<void> _clearDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      return;
    }

    await for (final entity in directory.list(followLinks: false)) {
      try {
        if (entity is Directory) {
          await _clearDirectory(entity.path);
        } else {
          await entity.delete();
        }
      } on FileSystemException catch (error) {
        // 不能删除正在播放的文件，但不应因此阻断其他缓存的清理。
        if (!isExpectedCacheDeletionFailure(error)) rethrow;
      }
    }

    try {
      await directory.delete();
    } on FileSystemException catch (error) {
      // 目录删除只是收尾操作；目录被保留或重新创建不影响缓存主体已被清理。
      if (!isExpectedCacheDeletionFailure(error)) rethrow;
    }
    await directory.create(recursive: true);
  }

  /// 释放已经初始化的缓存管理器。
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
