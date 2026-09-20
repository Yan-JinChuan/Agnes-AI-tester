// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoCreateRequest {


/// Create a copy of VideoCreateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoCreateRequestCopyWith<VideoCreateRequest> get copyWith => _$VideoCreateRequestCopyWithImpl<VideoCreateRequest>(this as VideoCreateRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoCreateRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoCreateRequest&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.numFrames, _this.numFrames) || other.numFrames == _this.numFrames)&&(identical(other.frameRate, _this.frameRate) || other.frameRate == _this.frameRate)&&(identical(other.numInferenceSteps, _this.numInferenceSteps) || other.numInferenceSteps == _this.numInferenceSteps)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&(identical(other.negativePrompt, _this.negativePrompt) || other.negativePrompt == _this.negativePrompt)&&(identical(other.image, _this.image) || other.image == _this.image)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&const DeepCollectionEquality().equals(other.extraBody, _this.extraBody));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VideoCreateRequest;
  return Object.hash(runtimeType,_this.model,_this.prompt,_this.width,_this.height,_this.numFrames,_this.frameRate,_this.numInferenceSteps,_this.seed,_this.negativePrompt,_this.image,_this.mode,const DeepCollectionEquality().hash(_this.extraBody));
}

@override
String toString() {
  final _this = this as VideoCreateRequest;
  return 'VideoCreateRequest(model: ${_this.model}, prompt: ${_this.prompt}, width: ${_this.width}, height: ${_this.height}, numFrames: ${_this.numFrames}, frameRate: ${_this.frameRate}, numInferenceSteps: ${_this.numInferenceSteps}, seed: ${_this.seed}, negativePrompt: ${_this.negativePrompt}, image: ${_this.image}, mode: ${_this.mode}, extraBody: ${_this.extraBody})';
}


}

/// @nodoc
abstract mixin class $VideoCreateRequestCopyWith<$Res>  {
  factory $VideoCreateRequestCopyWith(VideoCreateRequest value, $Res Function(VideoCreateRequest) _then) = _$VideoCreateRequestCopyWithImpl;
@useResult
$Res call({
 String model, String prompt, int width, int height,@JsonKey(name: 'num_frames') int numFrames,@JsonKey(name: 'frame_rate') double frameRate,@JsonKey(name: 'num_inference_steps', includeIfNull: false) int? numInferenceSteps,@JsonKey(includeIfNull: false) int? seed,@JsonKey(name: 'negative_prompt', includeIfNull: false) String? negativePrompt,@JsonKey(includeIfNull: false) String? image,@JsonKey(includeIfNull: false) String? mode,@JsonKey(name: 'extra_body', includeIfNull: false) Map<String, dynamic>? extraBody
});




}
/// @nodoc
class _$VideoCreateRequestCopyWithImpl<$Res>
    implements $VideoCreateRequestCopyWith<$Res> {
  _$VideoCreateRequestCopyWithImpl(this._self, this._then);

  final VideoCreateRequest _self;
  final $Res Function(VideoCreateRequest) _then;

/// Create a copy of VideoCreateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? prompt = null,Object? width = null,Object? height = null,Object? numFrames = null,Object? frameRate = null,Object? numInferenceSteps = freezed,Object? seed = freezed,Object? negativePrompt = freezed,Object? image = freezed,Object? mode = freezed,Object? extraBody = freezed,}) {
  return _then(VideoCreateRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,numFrames: null == numFrames ? _self.numFrames : numFrames // ignore: cast_nullable_to_non_nullable
as int,frameRate: null == frameRate ? _self.frameRate : frameRate // ignore: cast_nullable_to_non_nullable
as double,numInferenceSteps: freezed == numInferenceSteps ? _self.numInferenceSteps : numInferenceSteps // ignore: cast_nullable_to_non_nullable
as int?,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,negativePrompt: freezed == negativePrompt ? _self.negativePrompt : negativePrompt // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,extraBody: freezed == extraBody ? _self.extraBody : extraBody // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoCreateRequest].
extension VideoCreateRequestPatterns on VideoCreateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}


/// @nodoc
mixin _$VideoJobResponse {


/// Create a copy of VideoJobResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoJobResponseCopyWith<VideoJobResponse> get copyWith => _$VideoJobResponseCopyWithImpl<VideoJobResponse>(this as VideoJobResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoJobResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoJobResponse&&(identical(other.videoId, _this.videoId) || other.videoId == _this.videoId)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.taskId, _this.taskId) || other.taskId == _this.taskId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.percent, _this.percent) || other.percent == _this.percent)&&(identical(other.progressPercent, _this.progressPercent) || other.progressPercent == _this.progressPercent)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.videoUrl, _this.videoUrl) || other.videoUrl == _this.videoUrl)&&(identical(other.videoUrlCamel, _this.videoUrlCamel) || other.videoUrlCamel == _this.videoUrlCamel)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.seconds, _this.seconds) || other.seconds == _this.seconds)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.metadata, _this.metadata) || other.metadata == _this.metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VideoJobResponse;
  return Object.hash(runtimeType,_this.videoId,_this.id,_this.taskId,_this.status,_this.state,_this.progress,_this.percent,_this.progressPercent,_this.url,_this.videoUrl,_this.videoUrlCamel,_this.error,_this.message,_this.seconds,_this.size,_this.metadata);
}

@override
String toString() {
  final _this = this as VideoJobResponse;
  return 'VideoJobResponse(videoId: ${_this.videoId}, id: ${_this.id}, taskId: ${_this.taskId}, status: ${_this.status}, state: ${_this.state}, progress: ${_this.progress}, percent: ${_this.percent}, progressPercent: ${_this.progressPercent}, url: ${_this.url}, videoUrl: ${_this.videoUrl}, videoUrlCamel: ${_this.videoUrlCamel}, error: ${_this.error}, message: ${_this.message}, seconds: ${_this.seconds}, size: ${_this.size}, metadata: ${_this.metadata})';
}


}

/// @nodoc
abstract mixin class $VideoJobResponseCopyWith<$Res>  {
  factory $VideoJobResponseCopyWith(VideoJobResponse value, $Res Function(VideoJobResponse) _then) = _$VideoJobResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'video_id') String? videoId, String? id,@JsonKey(name: 'task_id') String? taskId, String? status, String? state,@JsonKey(fromJson: _numFromJson) num? progress,@JsonKey(fromJson: _numFromJson) num? percent,@JsonKey(name: 'progress_percent', fromJson: _numFromJson) num? progressPercent, String? url,@JsonKey(name: 'video_url') String? videoUrl,@JsonKey(name: 'videoUrl') String? videoUrlCamel, String? error, String? message,@JsonKey(fromJson: _numFromJson) num? seconds, String? size, VideoMetadata? metadata
});


$VideoMetadataCopyWith<$Res>? get metadata;

}
/// @nodoc
class _$VideoJobResponseCopyWithImpl<$Res>
    implements $VideoJobResponseCopyWith<$Res> {
  _$VideoJobResponseCopyWithImpl(this._self, this._then);

  final VideoJobResponse _self;
  final $Res Function(VideoJobResponse) _then;

/// Create a copy of VideoJobResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? videoId = freezed,Object? id = freezed,Object? taskId = freezed,Object? status = freezed,Object? state = freezed,Object? progress = freezed,Object? percent = freezed,Object? progressPercent = freezed,Object? url = freezed,Object? videoUrl = freezed,Object? videoUrlCamel = freezed,Object? error = freezed,Object? message = freezed,Object? seconds = freezed,Object? size = freezed,Object? metadata = freezed,}) {
  return _then(VideoJobResponse(
videoId: freezed == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as num?,percent: freezed == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as num?,progressPercent: freezed == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as num?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrlCamel: freezed == videoUrlCamel ? _self.videoUrlCamel : videoUrlCamel // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,seconds: freezed == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as num?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as VideoMetadata?,
  ));
}
/// Create a copy of VideoJobResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $VideoMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoJobResponse].
extension VideoJobResponsePatterns on VideoJobResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}


/// @nodoc
mixin _$VideoMetadata {


/// Create a copy of VideoMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoMetadataCopyWith<VideoMetadata> get copyWith => _$VideoMetadataCopyWithImpl<VideoMetadata>(this as VideoMetadata, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoMetadata;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoMetadata&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.seconds, _this.seconds) || other.seconds == _this.seconds)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.sizeMapping, _this.sizeMapping) || other.sizeMapping == _this.sizeMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VideoMetadata;
  return Object.hash(runtimeType,_this.url,_this.seconds,_this.message,_this.sizeMapping);
}

@override
String toString() {
  final _this = this as VideoMetadata;
  return 'VideoMetadata(url: ${_this.url}, seconds: ${_this.seconds}, message: ${_this.message}, sizeMapping: ${_this.sizeMapping})';
}


}

/// @nodoc
abstract mixin class $VideoMetadataCopyWith<$Res>  {
  factory $VideoMetadataCopyWith(VideoMetadata value, $Res Function(VideoMetadata) _then) = _$VideoMetadataCopyWithImpl;
@useResult
$Res call({
 String? url,@JsonKey(fromJson: _numFromJson) num? seconds, String? message,@JsonKey(name: 'size_mapping') VideoSizeMapping? sizeMapping
});


$VideoSizeMappingCopyWith<$Res>? get sizeMapping;

}
/// @nodoc
class _$VideoMetadataCopyWithImpl<$Res>
    implements $VideoMetadataCopyWith<$Res> {
  _$VideoMetadataCopyWithImpl(this._self, this._then);

  final VideoMetadata _self;
  final $Res Function(VideoMetadata) _then;

/// Create a copy of VideoMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? seconds = freezed,Object? message = freezed,Object? sizeMapping = freezed,}) {
  return _then(VideoMetadata(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,seconds: freezed == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as num?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sizeMapping: freezed == sizeMapping ? _self.sizeMapping : sizeMapping // ignore: cast_nullable_to_non_nullable
as VideoSizeMapping?,
  ));
}
/// Create a copy of VideoMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSizeMappingCopyWith<$Res>? get sizeMapping {
    if (_self.sizeMapping == null) {
    return null;
  }

  return $VideoSizeMappingCopyWith<$Res>(_self.sizeMapping!, (value) {
    return _then(_self.copyWith(sizeMapping: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoMetadata].
extension VideoMetadataPatterns on VideoMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}


/// @nodoc
mixin _$VideoSizeMapping {


/// Create a copy of VideoSizeMapping
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoSizeMappingCopyWith<VideoSizeMapping> get copyWith => _$VideoSizeMappingCopyWithImpl<VideoSizeMapping>(this as VideoSizeMapping, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoSizeMapping;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoSizeMapping&&(identical(other.actualSize, _this.actualSize) || other.actualSize == _this.actualSize)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VideoSizeMapping;
  return Object.hash(runtimeType,_this.actualSize,_this.message);
}

@override
String toString() {
  final _this = this as VideoSizeMapping;
  return 'VideoSizeMapping(actualSize: ${_this.actualSize}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $VideoSizeMappingCopyWith<$Res>  {
  factory $VideoSizeMappingCopyWith(VideoSizeMapping value, $Res Function(VideoSizeMapping) _then) = _$VideoSizeMappingCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'actual_size') String? actualSize, String? message
});




}
/// @nodoc
class _$VideoSizeMappingCopyWithImpl<$Res>
    implements $VideoSizeMappingCopyWith<$Res> {
  _$VideoSizeMappingCopyWithImpl(this._self, this._then);

  final VideoSizeMapping _self;
  final $Res Function(VideoSizeMapping) _then;

/// Create a copy of VideoSizeMapping
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actualSize = freezed,Object? message = freezed,}) {
  return _then(VideoSizeMapping(
actualSize: freezed == actualSize ? _self.actualSize : actualSize // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoSizeMapping].
extension VideoSizeMappingPatterns on VideoSizeMapping {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
