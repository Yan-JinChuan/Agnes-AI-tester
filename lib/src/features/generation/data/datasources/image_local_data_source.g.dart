// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供图片历史数据源，并复用应用唯一的 Drift 数据库。

@ProviderFor(imageLocalDataSource)
final imageLocalDataSourceProvider = ImageLocalDataSourceProvider._();

/// 提供图片历史数据源，并复用应用唯一的 Drift 数据库。

final class ImageLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ImageLocalDataSource,
          ImageLocalDataSource,
          ImageLocalDataSource
        >
    with $Provider<ImageLocalDataSource> {
  /// 提供图片历史数据源，并复用应用唯一的 Drift 数据库。
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
    r'1407a7d6b8b40cfd28345ae54d8e555836d5d442';
