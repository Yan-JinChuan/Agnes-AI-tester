import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_catalog_api_models.freezed.dart';
part 'model_catalog_api_models.g.dart';

@Freezed(toJson: false)
class const ModelCatalogResponse({
  final List<Object?>? data,
  final List<Object?>? models,
}) with _$ModelCatalogResponse {
  factory ModelCatalogResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelCatalogResponseFromJson(json);
}
