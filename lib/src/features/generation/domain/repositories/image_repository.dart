import '../models/image_generation_record.dart';

abstract interface class ImageRepository {
  Future<List<ImageGenerationRecord>> history();

  Future<ImageGenerationRecord> generate({
    required String prompt,
    required String size,
  });

  /// Deletes one persisted image generation by its SQLite identifier.
  Future<void> delete({required int id});
}
