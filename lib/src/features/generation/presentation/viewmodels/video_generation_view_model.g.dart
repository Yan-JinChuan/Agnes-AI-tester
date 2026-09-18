// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_generation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoGenerationViewModel)
final videoGenerationViewModelProvider = VideoGenerationViewModelProvider._();

final class VideoGenerationViewModelProvider
    extends $NotifierProvider<VideoGenerationViewModel, VideoState> {
  VideoGenerationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoGenerationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoGenerationViewModelHash();

  @$internal
  @override
  VideoGenerationViewModel create() => VideoGenerationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VideoState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VideoState>(value),
    );
  }
}

String _$videoGenerationViewModelHash() =>
    r'6c33f76a6a86ff23a62cb001cd0aaa9bdeee0fcf';

abstract class _$VideoGenerationViewModel extends $Notifier<VideoState> {
  VideoState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<VideoState, VideoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VideoState, VideoState>,
              VideoState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
