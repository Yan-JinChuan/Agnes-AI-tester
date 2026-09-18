// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<DioApiClient, DioApiClient, DioApiClient>
    with $Provider<DioApiClient> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<DioApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DioApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DioApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DioApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'a3b3c59f70fc0d5a415a992be9e24a39db1b0f2d';
