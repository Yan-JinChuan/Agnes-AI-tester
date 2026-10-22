/// 描述应用媒体缓存的磁盘占用情况。
class CacheUsage {
  /// 创建一次媒体缓存占用快照。
  const CacheUsage({required this.imageBytes, required this.videoBytes});

  /// 图片缓存占用的字节数。
  final int imageBytes;

  /// 普通视频缓存占用的字节数。
  final int videoBytes;

  /// 表示所有缓存均为空的快照。
  static const empty = CacheUsage(imageBytes: 0, videoBytes: 0);

  /// 所有受管理媒体缓存占用的总字节数。
  int get totalBytes => imageBytes + videoBytes;
}
