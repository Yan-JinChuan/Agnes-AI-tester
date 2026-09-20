class VideoGenerationOptions {
  const VideoGenerationOptions({
    this.width = 1152,
    this.height = 768,
    this.numFrames = 121,
    this.frameRate = 24,
    this.numInferenceSteps,
    this.seed,
    this.negativePrompt,
    this.imageUrl,
    this.mode,
    this.keyframeUrls = const [],
    this.seconds = '5',
    this.size = '720P',
    this.aspectRatio = '16:9',
    this.firstFrame,
    this.lastFrame,
    this.imageUrls = const [],
    this.audioUrls = const [],
    this.referenceVideos = const [],
  });

  // Agnes Video 2.0 fields. They remain here so existing history and the
  // legacy model can continue to be used.
  final int width;
  final int height;
  final int numFrames;
  final double frameRate;
  final int? numInferenceSteps;
  final String? imageUrl;
  final List<String> keyframeUrls;

  // Agnes Video 2.5+ fields.
  final String seconds;
  final String size;
  final String aspectRatio;
  final String? firstFrame;
  final String? lastFrame;
  final List<String> imageUrls;
  final List<String> audioUrls;
  final List<VideoReference> referenceVideos;

  final int? seed;
  final String? negativePrompt;
  final String? mode;

  VideoGenerationOptions copyWith({
    int? width,
    int? height,
    int? numFrames,
    double? frameRate,
    int? numInferenceSteps,
    int? seed,
    String? negativePrompt,
    String? imageUrl,
    String? mode,
    List<String>? keyframeUrls,
    String? seconds,
    String? size,
    String? aspectRatio,
    String? firstFrame,
    String? lastFrame,
    List<String>? imageUrls,
    List<String>? audioUrls,
    List<VideoReference>? referenceVideos,
  }) {
    return VideoGenerationOptions(
      width: width ?? this.width,
      height: height ?? this.height,
      numFrames: numFrames ?? this.numFrames,
      frameRate: frameRate ?? this.frameRate,
      numInferenceSteps: numInferenceSteps ?? this.numInferenceSteps,
      seed: seed ?? this.seed,
      negativePrompt: negativePrompt ?? this.negativePrompt,
      imageUrl: imageUrl ?? this.imageUrl,
      mode: mode ?? this.mode,
      keyframeUrls: keyframeUrls ?? this.keyframeUrls,
      seconds: seconds ?? this.seconds,
      size: size ?? this.size,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      firstFrame: firstFrame ?? this.firstFrame,
      lastFrame: lastFrame ?? this.lastFrame,
      imageUrls: imageUrls ?? this.imageUrls,
      audioUrls: audioUrls ?? this.audioUrls,
      referenceVideos: referenceVideos ?? this.referenceVideos,
    );
  }
}

class VideoReference {
  const VideoReference({
    required this.url,
    this.startSeconds = 0,
    this.requireAudio = false,
  });

  final String url;
  final double startSeconds;
  final bool requireAudio;
}

bool isAgnesVideo25OrLater(String model) {
  final match = RegExp(
    r'video-v?(\d+)\.(\d+)',
    caseSensitive: false,
  ).firstMatch(model.trim());
  if (match == null) return false;
  final major = int.parse(match.group(1)!);
  final minor = int.parse(match.group(2)!);
  return major > 2 || (major == 2 && minor >= 5);
}
