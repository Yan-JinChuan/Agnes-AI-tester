// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImageGenerationViewModel)
final imageGenerationViewModelProvider = ImageGenerationViewModelProvider._();

final class ImageGenerationViewModelProvider
    extends $NotifierProvider<ImageGenerationViewModel, ImageState> {
  ImageGenerationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageGenerationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageGenerationViewModelHash();

  @$internal
  @override
  ImageGenerationViewModel create() => ImageGenerationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageState>(value),
    );
  }
}

String _$imageGenerationViewModelHash() =>
    r'6ed0fa6ce7422bf28d2bf41970d0f1a0e78eb207';

abstract class _$ImageGenerationViewModel extends $Notifier<ImageState> {
  ImageState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ImageState, ImageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ImageState, ImageState>,
              ImageState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
