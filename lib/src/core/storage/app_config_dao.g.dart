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
    extends
        $FunctionalProvider<
          AsyncValue<AppConfigDao>,
          AppConfigDao,
          FutureOr<AppConfigDao>
        >
    with $FutureModifier<AppConfigDao>, $FutureProvider<AppConfigDao> {
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
  $FutureProviderElement<AppConfigDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppConfigDao> create(Ref ref) {
    return appConfigDao(ref);
  }
}

String _$appConfigDaoHash() => r'8e342927746c248dba17ad81edb3ae48dc73a132';
