// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageLocalDataSource)
final imageLocalDataSourceProvider = ImageLocalDataSourceProvider._();

final class ImageLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ImageLocalDataSource,
          ImageLocalDataSource,
          ImageLocalDataSource
        >
    with $Provider<ImageLocalDataSource> {
  ImageLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ImageLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImageLocalDataSource create(Ref ref) {
    return imageLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageLocalDataSource>(value),
    );
  }
}

String _$imageLocalDataSourceHash() =>
    r'678accd93d78a45d947ff7ddaa1479892e4bc6ad';
