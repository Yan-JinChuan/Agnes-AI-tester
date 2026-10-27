// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_dao.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appConfigDao)
final appConfigDaoProvider = AppConfigDaoProvider._();

final class AppConfigDaoProvider
    extends $FunctionalProvider<AppConfigDao, AppConfigDao, AppConfigDao>
    with $Provider<AppConfigDao> {
  AppConfigDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigDaoHash();

  @$internal
  @override
  $ProviderElement<AppConfigDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppConfigDao create(Ref ref) {
    return appConfigDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfigDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfigDao>(value),
    );
  }
}

String _$appConfigDaoHash() => r'4253f47772456efd5eb4ac3413e9797d4e92e25b';
