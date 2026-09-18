// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoRemoteDataSource)
final videoRemoteDataSourceProvider = VideoRemoteDataSourceProvider._();

final class VideoRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          VideoRemoteDataSource,
          VideoRemoteDataSource,
          VideoRemoteDataSource
        >
    with $Provider<VideoRemoteDataSource> {
  VideoRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<VideoRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VideoRemoteDataSource create(Ref ref) {
    return videoRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoRemoteDataSource>(value),
    );
  }
}

String _$videoRemoteDataSourceHash() =>
    r'826efaed6d5108e8ed78607259f8426e93676cb7';
