// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供聊天本地数据源，并复用应用唯一的 Drift 数据库。

@ProviderFor(chatLocalDataSource)
final chatLocalDataSourceProvider = ChatLocalDataSourceProvider._();

/// 提供聊天本地数据源，并复用应用唯一的 Drift 数据库。

final class ChatLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ChatLocalDataSource,
          ChatLocalDataSource,
          ChatLocalDataSource
        >
    with $Provider<ChatLocalDataSource> {
  /// 提供聊天本地数据源，并复用应用唯一的 Drift 数据库。
  ChatLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ChatLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatLocalDataSource create(Ref ref) {
    return chatLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatLocalDataSource>(value),
    );
  }
}

String _$chatLocalDataSourceHash() =>
    r'f731f5291293a00c11fc6e1ee1a3b46dacd7f9b6';
