// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_catalog_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(modelCatalogRemoteDataSource)
final modelCatalogRemoteDataSourceProvider =
    ModelCatalogRemoteDataSourceProvider._();

final class ModelCatalogRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ModelCatalogRemoteDataSource,
          ModelCatalogRemoteDataSource,
          ModelCatalogRemoteDataSource
        >
    with $Provider<ModelCatalogRemoteDataSource> {
  ModelCatalogRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'modelCatalogRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$modelCatalogRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ModelCatalogRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ModelCatalogRemoteDataSource create(Ref ref) {
    return modelCatalogRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ModelCatalogRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ModelCatalogRemoteDataSource>(value),
    );
  }
}

String _$modelCatalogRemoteDataSourceHash() =>
    r'b3323ff66207dd42095f36a044d4236b8814bdac';
