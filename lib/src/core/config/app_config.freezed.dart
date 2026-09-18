// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {


/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.apiKey, _this.apiKey) || other.apiKey == _this.apiKey)&&(identical(other.baseUrl, _this.baseUrl) || other.baseUrl == _this.baseUrl)&&(identical(other.textModel, _this.textModel) || other.textModel == _this.textModel)&&(identical(other.imageModel, _this.imageModel) || other.imageModel == _this.imageModel)&&(identical(other.videoModel, _this.videoModel) || other.videoModel == _this.videoModel)&&(identical(other.cacheDirectory, _this.cacheDirectory) || other.cacheDirectory == _this.cacheDirectory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppConfig;
  return Object.hash(runtimeType,_this.apiKey,_this.baseUrl,_this.textModel,_this.imageModel,_this.videoModel,_this.cacheDirectory);
}

@override
String toString() {
  final _this = this as AppConfig;
  return 'AppConfig(apiKey: ${_this.apiKey}, baseUrl: ${_this.baseUrl}, textModel: ${_this.textModel}, imageModel: ${_this.imageModel}, videoModel: ${_this.videoModel}, cacheDirectory: ${_this.cacheDirectory})';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl,@JsonKey(name: 'text_model') String textModel,@JsonKey(name: 'image_model') String imageModel,@JsonKey(name: 'video_model') String videoModel,@JsonKey(name: 'cache_directory') String cacheDirectory
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiKey = null,Object? baseUrl = null,Object? textModel = null,Object? imageModel = null,Object? videoModel = null,Object? cacheDirectory = null,}) {
  return _then(AppConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,textModel: null == textModel ? _self.textModel : textModel // ignore: cast_nullable_to_non_nullable
as String,imageModel: null == imageModel ? _self.imageModel : imageModel // ignore: cast_nullable_to_non_nullable
as String,videoModel: null == videoModel ? _self.videoModel : videoModel // ignore: cast_nullable_to_non_nullable
as String,cacheDirectory: null == cacheDirectory ? _self.cacheDirectory : cacheDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'text_model')  String textModel, @JsonKey(name: 'image_model')  String imageModel, @JsonKey(name: 'video_model')  String videoModel, @JsonKey(name: 'cache_directory')  String cacheDirectory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.apiKey,_that.baseUrl,_that.textModel,_that.imageModel,_that.videoModel,_that.cacheDirectory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'text_model')  String textModel, @JsonKey(name: 'image_model')  String imageModel, @JsonKey(name: 'video_model')  String videoModel, @JsonKey(name: 'cache_directory')  String cacheDirectory)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.apiKey,_that.baseUrl,_that.textModel,_that.imageModel,_that.videoModel,_that.cacheDirectory);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'text_model')  String textModel, @JsonKey(name: 'image_model')  String imageModel, @JsonKey(name: 'video_model')  String videoModel, @JsonKey(name: 'cache_directory')  String cacheDirectory)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.apiKey,_that.baseUrl,_that.textModel,_that.imageModel,_that.videoModel,_that.cacheDirectory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppConfig extends AppConfig {
  const _AppConfig({@JsonKey(name: 'api_key') this.apiKey = '', @JsonKey(name: 'base_url') this.baseUrl = 'https://apihub.agnes-ai.com/v1', @JsonKey(name: 'text_model') this.textModel = 'agnes-2.5-flash', @JsonKey(name: 'image_model') this.imageModel = 'agnes-image-2.1-flash', @JsonKey(name: 'video_model') this.videoModel = 'agnes-video-v2.0', @JsonKey(name: 'cache_directory') this.cacheDirectory = ''}): super(apiKey: apiKey, baseUrl: baseUrl, textModel: textModel, imageModel: imageModel, videoModel: videoModel, cacheDirectory: cacheDirectory);
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

@override@JsonKey(name: 'api_key') final  String apiKey;
@override@JsonKey(name: 'base_url') final  String baseUrl;
@override@JsonKey(name: 'text_model') final  String textModel;
@override@JsonKey(name: 'image_model') final  String imageModel;
@override@JsonKey(name: 'video_model') final  String videoModel;
@override@JsonKey(name: 'cache_directory') final  String cacheDirectory;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.textModel, textModel) || other.textModel == textModel)&&(identical(other.imageModel, imageModel) || other.imageModel == imageModel)&&(identical(other.videoModel, videoModel) || other.videoModel == videoModel)&&(identical(other.cacheDirectory, cacheDirectory) || other.cacheDirectory == cacheDirectory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,apiKey,baseUrl,textModel,imageModel,videoModel,cacheDirectory);
}

@override
String toString() {
    return 'AppConfig(apiKey: $apiKey, baseUrl: $baseUrl, textModel: $textModel, imageModel: $imageModel, videoModel: $videoModel, cacheDirectory: $cacheDirectory)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl,@JsonKey(name: 'text_model') String textModel,@JsonKey(name: 'image_model') String imageModel,@JsonKey(name: 'video_model') String videoModel,@JsonKey(name: 'cache_directory') String cacheDirectory
});




}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? textModel = null,Object? imageModel = null,Object? videoModel = null,Object? cacheDirectory = null,}) {
  return _then(_AppConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,textModel: null == textModel ? _self.textModel : textModel // ignore: cast_nullable_to_non_nullable
as String,imageModel: null == imageModel ? _self.imageModel : imageModel // ignore: cast_nullable_to_non_nullable
as String,videoModel: null == videoModel ? _self.videoModel : videoModel // ignore: cast_nullable_to_non_nullable
as String,cacheDirectory: null == cacheDirectory ? _self.cacheDirectory : cacheDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
