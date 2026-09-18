import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/models/model_info.dart';
import 'model_catalog_api.dart';

part 'model_catalog_remote_data_source.g.dart';

abstract interface class ModelCatalogRemoteDataSource {
  Future<List<ModelInfo>> fetchModels();
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
  Future<List<ModelInfo>> fetchModels() async {
    final response = await client.execute(api.fetchModels);
    final rawModels = response.data ?? response.models;
    if (rawModels == null) {
      throw const ApiException(message: '模型接口没有返回 data 列表。');
    }

    final models = <ModelInfo>[];
    for (final rawModel in rawModels) {
      if (rawModel is String && rawModel.trim().isNotEmpty) {
        models.add(ModelInfo(id: rawModel.trim()));
        continue;
      }
      if (rawModel is! Map) continue;
      final id = rawModel['id'] ?? rawModel['name'] ?? rawModel['model'];
      if (id is! String || id.trim().isEmpty) continue;
      final ownedBy = rawModel['owned_by'] ?? rawModel['ownedBy'];
      models.add(
        ModelInfo(
          id: id.trim(),
          ownedBy: ownedBy is String && ownedBy.trim().isNotEmpty
              ? ownedBy.trim()
              : null,
        ),
      );
    }
    models.sort((a, b) => a.id.compareTo(b.id));
    return models;
  }
}
