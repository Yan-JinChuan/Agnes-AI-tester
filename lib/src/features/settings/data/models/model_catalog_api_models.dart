import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/model_info.dart';

part 'model_catalog_api_models.freezed.dart';
part 'model_catalog_api_models.g.dart';

@Freezed(toJson: false)
@JsonSerializable(createToJson: false)
class const ModelCatalogResponse({
  final List<Object?>? data,
  final List<Object?>? models,
}) with _$ModelCatalogResponse {
  List<ModelInfo> toDomain() {
    final rawModels = data ?? models;
    if (rawModels == null) return const [];

    final result = <ModelInfo>[];
    for (final rawModel in rawModels) {
      if (rawModel is String && rawModel.trim().isNotEmpty) {
        result.add(ModelInfo(id: rawModel.trim()));
        continue;
      }
      if (rawModel is! Map) continue;
      final id = rawModel['id'] ?? rawModel['name'] ?? rawModel['model'];
      if (id is! String || id.trim().isEmpty) continue;
      final ownedBy = rawModel['owned_by'] ?? rawModel['ownedBy'];
      result.add(
        ModelInfo(
          id: id.trim(),
          ownedBy: ownedBy is String && ownedBy.trim().isNotEmpty
              ? ownedBy.trim()
              : null,
        ),
      );
    }
    result.sort((a, b) => a.id.compareTo(b.id));
    return result;
  }

  factory ModelCatalogResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelCatalogResponseFromJson(json);
}
