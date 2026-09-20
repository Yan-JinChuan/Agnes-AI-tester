import 'video_generation_options.dart';
import 'video_job.dart';
import 'video_job_status.dart';

class VideoGenerationRecord {
  const VideoGenerationRecord({
    this.id,
    required this.videoId,
    required this.prompt,
    required this.model,
    this.options = const VideoGenerationOptions(),
    required this.status,
    required this.progress,
    this.url,
    this.error,
    this.actualSize,
    this.seconds,
    this.metadataMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String videoId;
  final String prompt;
  final String model;
  final VideoGenerationOptions options;
  final VideoJobStatus status;
  final int progress;
  final String? url;
  final String? error;
  final String? actualSize;
  final double? seconds;
  final String? metadataMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  VideoJob get job => VideoJob(
    id: videoId,
    status: status,
    progress: progress,
    url: url,
    error: error,
    actualSize: actualSize,
    seconds: seconds,
    metadataMessage: metadataMessage,
  );

  VideoGenerationRecord updateFromJob(VideoJob job) {
    return VideoGenerationRecord(
      id: id,
      videoId: videoId,
      prompt: prompt,
      model: model,
      options: options,
      status: job.status,
      progress: job.progress,
      url: job.url,
      error: job.error,
      actualSize: job.actualSize ?? actualSize,
      seconds: job.seconds ?? seconds,
      metadataMessage: job.metadataMessage ?? metadataMessage,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
