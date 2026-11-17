// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供视频历史数据源，并复用应用唯一的 Drift 数据库。

@ProviderFor(videoLocalDataSource)
final videoLocalDataSourceProvider = VideoLocalDataSourceProvider._();

/// 提供视频历史数据源，并复用应用唯一的 Drift 数据库。

final class VideoLocalDataSourceProvider
    extends
        $FunctionalProvider<
          VideoLocalDataSource,
          VideoLocalDataSource,
          VideoLocalDataSource
        >
    with $Provider<VideoLocalDataSource> {
  /// 提供视频历史数据源，并复用应用唯一的 Drift 数据库。
  VideoLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<VideoLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VideoLocalDataSource create(Ref ref) {
    return videoLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoLocalDataSource>(value),
    );
  }
}

String _$videoLocalDataSourceHash() =>
    r'6d14df2e14250ffd42f71d2be04b3a38a0917b06';
