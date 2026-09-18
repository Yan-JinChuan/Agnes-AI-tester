import '../models/video_generation_options.dart';
import '../models/video_generation_record.dart';

abstract interface class VideoRepository {
  Future<List<VideoGenerationRecord>> history();

  Future<VideoGenerationRecord> create({
    required String prompt,
    required VideoGenerationOptions options,
  });

  Future<VideoGenerationRecord> poll({required String videoId});
}
