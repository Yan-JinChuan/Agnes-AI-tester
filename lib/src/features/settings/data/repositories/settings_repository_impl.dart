import '../../domain/models/model_info.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/model_catalog_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required this.remote});

  final ModelCatalogRemoteDataSource remote;

  @override
  Future<List<ModelInfo>> fetchModels() async {
    final response = await remote.fetchModels();
    return response.toDomain();
  }
}
