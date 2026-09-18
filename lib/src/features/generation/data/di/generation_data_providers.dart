import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/cache/app_media_cache.dart';
import '../../../../core/config/app_config_provider.dart';
import '../datasources/image_local_data_source.dart';
import '../datasources/image_remote_data_source.dart';
import '../datasources/video_local_data_source.dart';
import '../datasources/video_remote_data_source.dart';
import '../repositories/image_repository_impl.dart';
import '../repositories/video_repository_impl.dart';
import '../../domain/repositories/image_repository.dart';
import '../../domain/repositories/video_repository.dart';

part 'generation_data_providers.g.dart';

@riverpod
ImageRepository imageRepository(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return ImageRepositoryImpl(
    remote: ref.watch(imageRemoteDataSourceProvider),
    local: ref.watch(imageLocalDataSourceProvider),
    model: config.imageModel,
    cache: ref.watch(appMediaCacheProvider),
  );
}

@riverpod
VideoRepository videoRepository(Ref ref) {
  return VideoRepositoryImpl(
    remote: ref.watch(videoRemoteDataSourceProvider),
    local: ref.watch(videoLocalDataSourceProvider),
    model: ref.watch(appConfigProvider).videoModel,
  );
}
