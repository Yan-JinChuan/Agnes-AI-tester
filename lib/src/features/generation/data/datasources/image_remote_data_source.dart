import 'dart:convert';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/models/image_generation_result.dart';
import 'image_api.dart';
import '../models/image_api_models.dart';

part 'image_remote_data_source.g.dart';

abstract interface class ImageRemoteDataSource {
  Future<ImageGenerationResult> generate({
    required String model,
    required String prompt,
    required String size,
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
  Future<ImageGenerationResult> generate({
    required String model,
    required String prompt,
    required String size,
  }) async {
    final response = await client.execute(
      () => api.generateImage(
        ImageGenerationRequest(
          model: model,
          prompt: prompt,
          size: size,
          extraBody: const {'response_format': 'url'},
        ),
      ),
    );
    final first = response.data.firstOrNull;
    if (first == null) {
      throw const ApiException(message: '接口没有返回图片数据。');
    }
    final url = first.url;
    if (url != null && url.trim().isNotEmpty) {
      return ImageGenerationResult(url: url.trim());
    }
    final encoded = first.base64Json;
    if (encoded != null && encoded.isNotEmpty) {
      return ImageGenerationResult(bytes: _decodeBase64(encoded));
    }
    throw const ApiException(message: '图片响应中没有 url 或 b64_json。');
  }

  Uint8List _decodeBase64(String encoded) {
    final value = encoded.contains(',') ? encoded.split(',').last : encoded;
    try {
      return Uint8List.fromList(base64Decode(value));
    } on FormatException {
      throw const ApiException(message: '图片返回的 Base64 数据无效。');
    }
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
