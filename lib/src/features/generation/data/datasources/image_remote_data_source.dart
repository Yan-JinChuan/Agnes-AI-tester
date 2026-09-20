import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import 'image_api.dart';
import '../models/image_api_models.dart';

part 'image_remote_data_source.g.dart';

abstract interface class ImageRemoteDataSource {
  Future<ImageGenerationResponse> generate({
    required ImageGenerationRequest request,
  });
}

@riverpod
ImageRemoteDataSource imageRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return ImageRemoteDataSourceImpl(client: client, api: ImageApi(client.dio));
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  const ImageRemoteDataSourceImpl({required this.client, required this.api});

  final ApiClient client;
  final ImageApi api;

  @override
  Future<ImageGenerationResponse> generate({
    required ImageGenerationRequest request,
  }) {
    return client.execute(() => api.generateImage(request));
  }
}
