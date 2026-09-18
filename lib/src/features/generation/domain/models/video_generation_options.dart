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
  });

  final int width;
  final int height;
  final int numFrames;
  final double frameRate;
  final int? numInferenceSteps;
  final int? seed;
  final String? negativePrompt;
  final String? imageUrl;
  final String? mode;
  final List<String> keyframeUrls;

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
    );
  }
}
