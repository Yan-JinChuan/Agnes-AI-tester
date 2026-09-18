import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config_provider.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';
import '../repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';

part 'chat_data_providers.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepositoryImpl(
    remote: ref.watch(chatRemoteDataSourceProvider),
    local: ref.watch(chatLocalDataSourceProvider),
    model: ref.watch(appConfigProvider).textModel,
  );
}
