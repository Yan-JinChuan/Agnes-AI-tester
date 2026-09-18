import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/image_api_models.dart';

part 'image_api.g.dart';

@RestApi()
abstract class ImageApi {
  factory ImageApi(Dio dio) = _ImageApi;

  @POST('images/generations')
  Future<ImageGenerationResponse> generateImage(
    @Body() ImageGenerationRequest request,
  );
}
