import 'package:drift/drift.dart' show Value;

import '../../../../core/cache/app_media_cache.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/models/image_generation_record.dart';
import '../../domain/models/image_generation_result.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/image_local_data_source.dart';
import '../datasources/image_remote_data_source.dart';
import '../models/image_api_models.dart';

/// 协调图片生成接口、本地历史与媒体缓存，并负责数据库行到领域实体的转换。
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

  /// 读取本地图片历史并转换为领域记录。
  @override
  Future<List<ImageGenerationRecord>> history() async {
    final rows = await local.loadHistory();
    return rows.map(_fromRow).toList();
  }

  /// 生成图片、缓存可用媒体并持久化本地历史。
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

  /// 删除指定本地历史记录。
  @override
  Future<void> delete({required int id}) {
    return local.deleteGeneration(id: id);
  }

  /// 在 Repository 边界把远程 DTO 清洗为图片领域结果。
  ImageGenerationResult _toDomain(ImageData data) {
    try {
      return data.toDomain();
    } on FormatException catch (error) {
      throw ApiException(message: error.message);
    }
  }

  /// 尽力填充媒体缓存；缓存故障不应抹掉已经成功生成的结果。
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
      // 生成结果已可持久化；缓存异常不应把成功的 Agnes 响应改成失败。
    }
  }

  /// 将 Drift 图片行还原为领域记录。
  ImageGenerationRecord _fromRow(ImageGenerationRow row) {
    return ImageGenerationRecord(
      id: row.id,
      prompt: row.prompt,
      model: row.model,
      size: row.size,
      result: ImageGenerationResult(
        url: row.url?.trim(),
        bytes: row.imageBytes,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }

  /// 将领域记录映射为 Drift companion，显式表达可空列的写入值。
  ImageGenerationsCompanion _toRow(ImageGenerationRecord record) {
    return ImageGenerationsCompanion.insert(
      prompt: record.prompt,
      model: record.model,
      size: record.size,
      url: Value(record.result.url),
      imageBytes: Value(record.result.bytes),
      createdAt: record.createdAt.millisecondsSinceEpoch,
    );
  }
}
