// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_catalog_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModelCatalogViewModel)
final modelCatalogViewModelProvider = ModelCatalogViewModelProvider._();

final class ModelCatalogViewModelProvider
    extends $NotifierProvider<ModelCatalogViewModel, ModelCatalogState> {
  ModelCatalogViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'modelCatalogViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$modelCatalogViewModelHash();

  @$internal
  @override
  ModelCatalogViewModel create() => ModelCatalogViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ModelCatalogState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ModelCatalogState>(value),
    );
  }
}

String _$modelCatalogViewModelHash() =>
    r'92687380be9a2a883d32e259b24aa0ac8890d040';

abstract class _$ModelCatalogViewModel extends $Notifier<ModelCatalogState> {
  ModelCatalogState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ModelCatalogState, ModelCatalogState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ModelCatalogState, ModelCatalogState>,
              ModelCatalogState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
