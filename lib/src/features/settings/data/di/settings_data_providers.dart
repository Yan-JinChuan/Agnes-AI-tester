import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/model_catalog_remote_data_source.dart';
import '../repositories/settings_repository_impl.dart';

part 'settings_data_providers.g.dart';

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(
    remote: ref.watch(modelCatalogRemoteDataSourceProvider),
  );
}
