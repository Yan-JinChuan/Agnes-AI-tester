// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_media_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appMediaCache)
final appMediaCacheProvider = AppMediaCacheProvider._();

final class AppMediaCacheProvider
    extends $FunctionalProvider<AppMediaCache, AppMediaCache, AppMediaCache>
    with $Provider<AppMediaCache> {
  AppMediaCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appMediaCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appMediaCacheHash();

  @$internal
  @override
  $ProviderElement<AppMediaCache> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppMediaCache create(Ref ref) {
    return appMediaCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppMediaCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppMediaCache>(value),
    );
  }
}

String _$appMediaCacheHash() => r'1a3fc6dbc3eab85e07cb6b7547190d6f5e183ecd';
