import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/model_catalog_api_models.dart';

part 'model_catalog_api.g.dart';

@RestApi()
abstract class ModelCatalogApi {
  factory ModelCatalogApi(Dio dio) = _ModelCatalogApi;

  @GET('models')
  Future<ModelCatalogResponse> fetchModels();
}
