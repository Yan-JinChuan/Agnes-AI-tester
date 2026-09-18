import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// 在 Flutter 中，Web 端不能使用 dart:io 库（因为浏览器沙箱没有传统的文件系统 File、Directory 等）
/// 根据当前运行平台的特性，在编译时动态选择导入不同的实现文件，从而实现跨平台兼容
import 'cache_manager_factory_stub.dart'
    if (dart.library.io) 'cache_manager_factory_io.dart'
    as implementation;

Future<CacheManager> createCacheManager(
  String configuredDirectory, {
  required String category,
}) {
  return implementation.createCacheManager(
    configuredDirectory,
    category: category,
  );
}

bool get cacheManagerSupportsCustomDirectory =>
    implementation.supportsCustomDirectory;
