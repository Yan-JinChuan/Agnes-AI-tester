import 'dart:typed_data';

import '../../../../core/cache/app_media_cache.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/models/image_generation_record.dart';
import '../../domain/models/image_generation_result.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/image_local_data_source.dart';
import '../datasources/image_remote_data_source.dart';
import '../models/image_api_models.dart';

class ImageRepositoryImpl implements ImageRepository {
  const ImageRepositoryImpl({
    required this.remote,
    required this.local,
    required this.model,
    required this.cache,
  });

  final ImageRemoteDataSource remote;
  final ImageLocalDataSource local;
  final String model;
  final AppMediaCache cache;

  @override
  Future<List<ImageGenerationRecord>> history() async {
    final rows = await local.loadHistory();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<ImageGenerationRecord> generate({
    required String prompt,
    required String size,
  }) async {
    final response = await remote.generate(
      request: ImageGenerationRequest(
        model: model,
        prompt: prompt,
        size: size,
        extraBody: const {'response_format': 'url'},
      ),
    );
    final first = response.data.isEmpty ? null : response.data.first;
    if (first == null) {
      throw const ApiException(message: '接口没有返回图片数据。');
    }
    final result = _toDomain(first);
    await _cacheResult(result, prompt);
    final record = ImageGenerationRecord(
      prompt: prompt,
      model: model,
      size: size,
      result: result,
      createdAt: DateTime.now(),
    );
    final id = await local.insertGeneration(_toRow(record));
    return record.copyWith(id: id);
  }

  @override
  Future<void> delete({required int id}) {
    return local.deleteGeneration(id: id);
  }

  ImageGenerationResult _toDomain(ImageData data) {
    try {
      return data.toDomain();
    } on FormatException catch (error) {
      throw ApiException(message: error.message);
    }
  }

  Future<void> _cacheResult(ImageGenerationResult result, String prompt) async {
    try {
      if (result.url != null && result.url!.isNotEmpty) {
        await cache.getImageBytes(result.url!);
      } else if (result.bytes != null) {
        await cache.putImageBytes(
          '$prompt:${DateTime.now().microsecondsSinceEpoch}',
          result.bytes!,
        );
      }
    } on Object {
      // The database keeps the original result, so a cache failure must not
      // turn a successful Agnes generation into an application error.
    }
  }

  ImageGenerationRecord _fromRow(Map<String, Object?> row) {
    final rawBytes = row['image_bytes'];
    final bytes = rawBytes is Uint8List
        ? rawBytes
        : rawBytes is List<int>
        ? Uint8List.fromList(rawBytes)
        : null;
    return ImageGenerationRecord(
      id: row['id'] as int?,
      prompt: row['prompt'] as String? ?? '',
      model: row['model'] as String? ?? '',
      size: row['size'] as String? ?? '',
      result: ImageGenerationResult(
        url: (row['url'] as String?)?.trim(),
        bytes: bytes,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
    );
  }

  Map<String, Object?> _toRow(ImageGenerationRecord record) {
    return {
      'prompt': record.prompt,
      'model': record.model,
      'size': record.size,
      'url': record.result.url,
      'image_bytes': record.result.bytes,
      'created_at': record.createdAt.millisecondsSinceEpoch,
    };
  }
}
