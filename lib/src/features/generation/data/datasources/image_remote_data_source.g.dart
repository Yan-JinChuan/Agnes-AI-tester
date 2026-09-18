// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageRemoteDataSource)
final imageRemoteDataSourceProvider = ImageRemoteDataSourceProvider._();

final class ImageRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ImageRemoteDataSource,
          ImageRemoteDataSource,
          ImageRemoteDataSource
        >
    with $Provider<ImageRemoteDataSource> {
  ImageRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ImageRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImageRemoteDataSource create(Ref ref) {
    return imageRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageRemoteDataSource>(value),
    );
  }
}

String _$imageRemoteDataSourceHash() =>
    r'e5e338fd8b82afd13b66ab32e4c2b7c1941f32a7';
