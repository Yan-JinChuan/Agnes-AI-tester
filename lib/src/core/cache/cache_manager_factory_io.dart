import 'package:file/file.dart' show Directory, File;
import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<CacheManager> createCacheManager(
  String configuredDirectory, {
  required String category,
}) async {
  final rootPath = await _resolveRootPath(configuredDirectory, category);
  final fileSystem = _DirectoryFileSystem(rootPath);
  final repository = JsonCacheInfoRepository(
    path: path.join(rootPath, 'cache-index.json'),
  );
  return CacheManager(
    Config(
      'agnes_media_cache_$category',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 500,
      repo: repository,
      fileSystem: fileSystem,
    ),
  );
}

bool get supportsCustomDirectory => true;

Future<String> _resolveRootPath(
  String configuredDirectory,
  String category,
) async {
  final root = configuredDirectory.trim().isEmpty
      ? path.join(
          (await getApplicationCacheDirectory()).path,
          'agnes_ai_tester',
        )
      : configuredDirectory.trim();
  return path.join(root, category);
}

class _DirectoryFileSystem implements FileSystem {
  _DirectoryFileSystem(String rootPath)
    : _directory = _createDirectory(rootPath);

  final Future<Directory> _directory;

  static Future<Directory> _createDirectory(String rootPath) async {
    const localFileSystem = LocalFileSystem();
    final directory = localFileSystem.directory(rootPath);
    await directory.create(recursive: true);
    return directory;
  }

  @override
  Future<File> createFile(String name) async {
    final directory = await _directory;
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
    return directory.childFile(name);
  }
}
