// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供应用级数据库依赖的注入入口。
///
/// 数据库必须由应用组合根（`main()`）完成异步打开后通过 override 注入，
/// 这样数据源在创建时拿到的就是可直接使用的连接，而不会把初始化等待
/// 泄漏到每一次 SQL 操作中。

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// 提供应用级数据库依赖的注入入口。
///
/// 数据库必须由应用组合根（`main()`）完成异步打开后通过 override 注入，
/// 这样数据源在创建时拿到的就是可直接使用的连接，而不会把初始化等待
/// 泄漏到每一次 SQL 操作中。

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// 提供应用级数据库依赖的注入入口。
  ///
  /// 数据库必须由应用组合根（`main()`）完成异步打开后通过 override 注入，
  /// 这样数据源在创建时拿到的就是可直接使用的连接，而不会把初始化等待
  /// 泄漏到每一次 SQL 操作中。
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'709b75461851260fc2660cec04f5a73927202546';
