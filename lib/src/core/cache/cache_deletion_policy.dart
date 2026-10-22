import 'dart:io';

/// 判断缓存清理过程中可以安全忽略的文件系统删除错误。
///
/// Windows 播放器仍持有文件时，系统可能返回文件占用错误；Android、Linux
/// 以及 Apple 平台在缓存内容已被清理但目录被并发重新创建时，可能返回
/// `ENOTEMPTY`。这两类错误不代表缓存主体清理失败，保留目录本身也不影响
/// 后续继续写入缓存。
bool isExpectedCacheDeletionFailure(FileSystemException error) {
  final errorCode = error.osError?.errorCode;
  return errorCode == 32 ||
      errorCode == 33 ||
      errorCode == 39 ||
      errorCode == 66 ||
      errorCode == 145;
}
