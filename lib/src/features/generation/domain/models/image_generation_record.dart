import 'image_generation_result.dart';

class ImageGenerationRecord {
  const ImageGenerationRecord({
    this.id,
    required this.prompt,
    required this.model,
    required this.size,
    required this.result,
    required this.createdAt,
  });

  final int? id;
  final String prompt;
  final String model;
  final String size;
  final ImageGenerationResult result;
  final DateTime createdAt;

  ImageGenerationRecord copyWith({int? id}) {
    return ImageGenerationRecord(
      id: id ?? this.id,
      prompt: prompt,
      model: model,
      size: size,
      result: result,
      createdAt: createdAt,
    );
  }
}
