// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 异步打开并持有应用唯一的 SQLite 连接。
///
/// 启动编排通过 `.future` 等待初始化完成；业务数据源不要直接等待，
/// 应继续使用下面的同步 [appDatabaseProvider]。

@ProviderFor(appDatabaseInitialization)
final appDatabaseInitializationProvider = AppDatabaseInitializationProvider._();

/// 异步打开并持有应用唯一的 SQLite 连接。
///
/// 启动编排通过 `.future` 等待初始化完成；业务数据源不要直接等待，
/// 应继续使用下面的同步 [appDatabaseProvider]。

final class AppDatabaseInitializationProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppDatabase>,
          AppDatabase,
          FutureOr<AppDatabase>
        >
    with $FutureModifier<AppDatabase>, $FutureProvider<AppDatabase> {
  /// 异步打开并持有应用唯一的 SQLite 连接。
  ///
  /// 启动编排通过 `.future` 等待初始化完成；业务数据源不要直接等待，
  /// 应继续使用下面的同步 [appDatabaseProvider]。
  AppDatabaseInitializationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseInitializationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseInitializationHash();

  @$internal
  @override
  $FutureProviderElement<AppDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppDatabase> create(Ref ref) {
    return appDatabaseInitialization(ref);
  }
}

String _$appDatabaseInitializationHash() =>
    r'c14beda2d53c003cf57279605dbccb4079d398b2';

/// 将已完成的异步数据库连接截断为同步依赖。

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// 将已完成的异步数据库连接截断为同步依赖。

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// 将已完成的异步数据库连接截断为同步依赖。
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

String _$appDatabaseHash() => r'c226035718a57ba6118d3f257552865ba412e134';
