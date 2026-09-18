import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/video_api_models.dart';

part 'video_api.g.dart';

@RestApi()
abstract class VideoApi {
  factory VideoApi(Dio dio) = _VideoApi;

  @POST('videos')
  Future<VideoJobResponse> createVideo(@Body() VideoCreateRequest request);

  @GET('/agnesapi')
  Future<VideoJobResponse> pollVideo({
    @Query('video_id') required String videoId,
    @Query('model_name') required String modelName,
  });
}
