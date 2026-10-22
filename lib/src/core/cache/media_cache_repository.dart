import 'cache_usage.dart';

/// 为设置页和其他应用服务提供缓存操作，隐藏底层 CacheManager 实现细节。
abstract interface class MediaCacheRepository {
  /// 读取所有受管理媒体缓存目录的占用快照。
  Future<CacheUsage> getUsage();

  /// 清理所有受管理媒体缓存。
  Future<void> clear();
}
