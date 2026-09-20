import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import 'model_catalog_api.dart';
import '../models/model_catalog_api_models.dart';

part 'model_catalog_remote_data_source.g.dart';

abstract interface class ModelCatalogRemoteDataSource {
  Future<ModelCatalogResponse> fetchModels();
}

@riverpod
ModelCatalogRemoteDataSource modelCatalogRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return AgnesModelCatalogRemoteDataSource(
    client: client,
    api: ModelCatalogApi(client.dio),
  );
}

class AgnesModelCatalogRemoteDataSource
    implements ModelCatalogRemoteDataSource {
  const AgnesModelCatalogRemoteDataSource({
    required this.client,
    required this.api,
  });

  final ApiClient client;
  final ModelCatalogApi api;

  @override
  Future<ModelCatalogResponse> fetchModels() {
    return client.execute(api.fetchModels);
  }
}
