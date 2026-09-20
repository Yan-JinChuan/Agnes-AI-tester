import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class const AppConfig({
  final String apiKey = "",
  final String baseUrl = "https://apihub.agnes-ai.com/v1",
  final String textModel = "agnes-2.5-flash",
  final String imageModel = "agnes-image-2.1-flash",
  final String videoModel = "agnes-video-2.5",
  final String cacheDirectory = "",
}) with _$AppConfig {
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
