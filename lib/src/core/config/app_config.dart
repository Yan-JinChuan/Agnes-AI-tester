import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
class const AppConfig({
  @JsonKey(name: 'api_key') final String apiKey = "",
  @JsonKey(name: 'base_url')
  final String baseUrl = "https://apihub.agnes-ai.com/v1",
  @JsonKey(name: 'text_model') final String textModel = "agnes-2.5-flash",
  @JsonKey(name: 'image_model')
  final String imageModel = "agnes-image-2.1-flash",
  @JsonKey(name: 'video_model') final String videoModel = "agnes-video-v2.0",
  @JsonKey(name: 'cache_directory') final String cacheDirectory = "",
}) with _$AppConfig {
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'api_key': apiKey,
      'base_url': baseUrl,
      'text_model': textModel,
      'image_model': imageModel,
      'video_model': videoModel,
      'cache_directory': cacheDirectory,
    };
  }
}
