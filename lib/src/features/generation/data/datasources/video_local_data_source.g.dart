// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoLocalDataSource)
final videoLocalDataSourceProvider = VideoLocalDataSourceProvider._();

final class VideoLocalDataSourceProvider
    extends
        $FunctionalProvider<
          VideoLocalDataSource,
          VideoLocalDataSource,
          VideoLocalDataSource
        >
    with $Provider<VideoLocalDataSource> {
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
    r'979fd5f8e1f90016a5b92d58f7f3a0ef8c380c23';
