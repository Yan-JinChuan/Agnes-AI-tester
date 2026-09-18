// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  apiKey: json['api_key'] as String? ?? '',
  baseUrl: json['base_url'] as String? ?? 'https://apihub.agnes-ai.com/v1',
  textModel: json['text_model'] as String? ?? 'agnes-2.5-flash',
  imageModel: json['image_model'] as String? ?? 'agnes-image-2.1-flash',
  videoModel: json['video_model'] as String? ?? 'agnes-video-v2.0',
  cacheDirectory: json['cache_directory'] as String? ?? '',
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'base_url': instance.baseUrl,
      'text_model': instance.textModel,
      'image_model': instance.imageModel,
      'video_model': instance.videoModel,
      'cache_directory': instance.cacheDirectory,
    };
