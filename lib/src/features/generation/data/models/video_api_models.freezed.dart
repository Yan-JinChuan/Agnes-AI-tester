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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoCreateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoCreateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoCreateRequest value)  $default,){
final _that = this;
switch (_that) {
case _VideoCreateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoCreateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VideoCreateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  String prompt,  int width,  int height, @JsonKey(name: 'num_frames')  int numFrames, @JsonKey(name: 'frame_rate')  double frameRate, @JsonKey(name: 'num_inference_steps', includeIfNull: false)  int? numInferenceSteps, @JsonKey(includeIfNull: false)  int? seed, @JsonKey(name: 'negative_prompt', includeIfNull: false)  String? negativePrompt, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false)  String? mode, @JsonKey(name: 'extra_body', includeIfNull: false)  Map<String, dynamic>? extraBody)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoCreateRequest() when $default != null:
return $default(_that.model,_that.prompt,_that.width,_that.height,_that.numFrames,_that.frameRate,_that.numInferenceSteps,_that.seed,_that.negativePrompt,_that.image,_that.mode,_that.extraBody);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  String prompt,  int width,  int height, @JsonKey(name: 'num_frames')  int numFrames, @JsonKey(name: 'frame_rate')  double frameRate, @JsonKey(name: 'num_inference_steps', includeIfNull: false)  int? numInferenceSteps, @JsonKey(includeIfNull: false)  int? seed, @JsonKey(name: 'negative_prompt', includeIfNull: false)  String? negativePrompt, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false)  String? mode, @JsonKey(name: 'extra_body', includeIfNull: false)  Map<String, dynamic>? extraBody)  $default,) {final _that = this;
switch (_that) {
case _VideoCreateRequest():
return $default(_that.model,_that.prompt,_that.width,_that.height,_that.numFrames,_that.frameRate,_that.numInferenceSteps,_that.seed,_that.negativePrompt,_that.image,_that.mode,_that.extraBody);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  String prompt,  int width,  int height, @JsonKey(name: 'num_frames')  int numFrames, @JsonKey(name: 'frame_rate')  double frameRate, @JsonKey(name: 'num_inference_steps', includeIfNull: false)  int? numInferenceSteps, @JsonKey(includeIfNull: false)  int? seed, @JsonKey(name: 'negative_prompt', includeIfNull: false)  String? negativePrompt, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false)  String? mode, @JsonKey(name: 'extra_body', includeIfNull: false)  Map<String, dynamic>? extraBody)?  $default,) {final _that = this;
switch (_that) {
case _VideoCreateRequest() when $default != null:
return $default(_that.model,_that.prompt,_that.width,_that.height,_that.numFrames,_that.frameRate,_that.numInferenceSteps,_that.seed,_that.negativePrompt,_that.image,_that.mode,_that.extraBody);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _VideoCreateRequest extends VideoCreateRequest {
  const _VideoCreateRequest({required this.model, required this.prompt, required this.width, required this.height, @JsonKey(name: 'num_frames') required this.numFrames, @JsonKey(name: 'frame_rate') required this.frameRate, @JsonKey(name: 'num_inference_steps', includeIfNull: false) this.numInferenceSteps, @JsonKey(includeIfNull: false) this.seed, @JsonKey(name: 'negative_prompt', includeIfNull: false) this.negativePrompt, @JsonKey(includeIfNull: false) this.image, @JsonKey(includeIfNull: false) this.mode, @JsonKey(name: 'extra_body', includeIfNull: false)  Map<String, dynamic>? extraBody}): _extraBody = extraBody,super(model: model, prompt: prompt, width: width, height: height, numFrames: numFrames, frameRate: frameRate, numInferenceSteps: numInferenceSteps, seed: seed, negativePrompt: negativePrompt, image: image, mode: mode, extraBody: extraBody);
  factory _VideoCreateRequest.fromJson(Map<String, dynamic> json) => _$VideoCreateRequestFromJson(json);

@override final  String model;
@override final  String prompt;
@override final  int width;
@override final  int height;
@override@JsonKey(name: 'num_frames') final  int numFrames;
@override@JsonKey(name: 'frame_rate') final  double frameRate;
@override@JsonKey(name: 'num_inference_steps', includeIfNull: false) final  int? numInferenceSteps;
@override@JsonKey(includeIfNull: false) final  int? seed;
@override@JsonKey(name: 'negative_prompt', includeIfNull: false) final  String? negativePrompt;
@override@JsonKey(includeIfNull: false) final  String? image;
@override@JsonKey(includeIfNull: false) final  String? mode;
 final  Map<String, dynamic>? _extraBody;
@override@JsonKey(name: 'extra_body', includeIfNull: false) Map<String, dynamic>? get extraBody {
  final value = _extraBody;
  if (value == null) return null;
  if (_extraBody is EqualUnmodifiableMapView) return _extraBody;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of VideoCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoCreateRequestCopyWith<_VideoCreateRequest> get copyWith => __$VideoCreateRequestCopyWithImpl<_VideoCreateRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoCreateRequest&&(identical(other.model, model) || other.model == model)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.numFrames, numFrames) || other.numFrames == numFrames)&&(identical(other.frameRate, frameRate) || other.frameRate == frameRate)&&(identical(other.numInferenceSteps, numInferenceSteps) || other.numInferenceSteps == numInferenceSteps)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.negativePrompt, negativePrompt) || other.negativePrompt == negativePrompt)&&(identical(other.image, image) || other.image == image)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.extraBody, _extraBody));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,model,prompt,width,height,numFrames,frameRate,numInferenceSteps,seed,negativePrompt,image,mode,const DeepCollectionEquality().hash(_extraBody));
}

@override
String toString() {
    return 'VideoCreateRequest(model: $model, prompt: $prompt, width: $width, height: $height, numFrames: $numFrames, frameRate: $frameRate, numInferenceSteps: $numInferenceSteps, seed: $seed, negativePrompt: $negativePrompt, image: $image, mode: $mode, extraBody: $extraBody)';
}


}

/// @nodoc
abstract mixin class _$VideoCreateRequestCopyWith<$Res> implements $VideoCreateRequestCopyWith<$Res> {
  factory _$VideoCreateRequestCopyWith(_VideoCreateRequest value, $Res Function(_VideoCreateRequest) _then) = __$VideoCreateRequestCopyWithImpl;
@override @useResult
$Res call({
 String model, String prompt, int width, int height,@JsonKey(name: 'num_frames') int numFrames,@JsonKey(name: 'frame_rate') double frameRate,@JsonKey(name: 'num_inference_steps', includeIfNull: false) int? numInferenceSteps,@JsonKey(includeIfNull: false) int? seed,@JsonKey(name: 'negative_prompt', includeIfNull: false) String? negativePrompt,@JsonKey(includeIfNull: false) String? image,@JsonKey(includeIfNull: false) String? mode,@JsonKey(name: 'extra_body', includeIfNull: false) Map<String, dynamic>? extraBody
});




}
/// @nodoc
class __$VideoCreateRequestCopyWithImpl<$Res>
    implements _$VideoCreateRequestCopyWith<$Res> {
  __$VideoCreateRequestCopyWithImpl(this._self, this._then);

  final _VideoCreateRequest _self;
  final $Res Function(_VideoCreateRequest) _then;

/// Create a copy of VideoCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? prompt = null,Object? width = null,Object? height = null,Object? numFrames = null,Object? frameRate = null,Object? numInferenceSteps = freezed,Object? seed = freezed,Object? negativePrompt = freezed,Object? image = freezed,Object? mode = freezed,Object? extraBody = freezed,}) {
  return _then(_VideoCreateRequest(
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
as String?,extraBody: freezed == extraBody ? _self._extraBody : extraBody // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
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
@JsonKey(name: 'video_id') String? videoId, String? id,@JsonKey(name: 'task_id') String? taskId, String? status, String? state, num? progress, num? percent,@JsonKey(name: 'progress_percent') num? progressPercent, String? url,@JsonKey(name: 'video_url') String? videoUrl,@JsonKey(name: 'videoUrl') String? videoUrlCamel, String? error, String? message, num? seconds, String? size, VideoMetadata? metadata
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoJobResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoJobResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoJobResponse value)  $default,){
final _that = this;
switch (_that) {
case _VideoJobResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoJobResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VideoJobResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'video_id')  String? videoId,  String? id, @JsonKey(name: 'task_id')  String? taskId,  String? status,  String? state,  num? progress,  num? percent, @JsonKey(name: 'progress_percent')  num? progressPercent,  String? url, @JsonKey(name: 'video_url')  String? videoUrl, @JsonKey(name: 'videoUrl')  String? videoUrlCamel,  String? error,  String? message,  num? seconds,  String? size,  VideoMetadata? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoJobResponse() when $default != null:
return $default(_that.videoId,_that.id,_that.taskId,_that.status,_that.state,_that.progress,_that.percent,_that.progressPercent,_that.url,_that.videoUrl,_that.videoUrlCamel,_that.error,_that.message,_that.seconds,_that.size,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'video_id')  String? videoId,  String? id, @JsonKey(name: 'task_id')  String? taskId,  String? status,  String? state,  num? progress,  num? percent, @JsonKey(name: 'progress_percent')  num? progressPercent,  String? url, @JsonKey(name: 'video_url')  String? videoUrl, @JsonKey(name: 'videoUrl')  String? videoUrlCamel,  String? error,  String? message,  num? seconds,  String? size,  VideoMetadata? metadata)  $default,) {final _that = this;
switch (_that) {
case _VideoJobResponse():
return $default(_that.videoId,_that.id,_that.taskId,_that.status,_that.state,_that.progress,_that.percent,_that.progressPercent,_that.url,_that.videoUrl,_that.videoUrlCamel,_that.error,_that.message,_that.seconds,_that.size,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'video_id')  String? videoId,  String? id, @JsonKey(name: 'task_id')  String? taskId,  String? status,  String? state,  num? progress,  num? percent, @JsonKey(name: 'progress_percent')  num? progressPercent,  String? url, @JsonKey(name: 'video_url')  String? videoUrl, @JsonKey(name: 'videoUrl')  String? videoUrlCamel,  String? error,  String? message,  num? seconds,  String? size,  VideoMetadata? metadata)?  $default,) {final _that = this;
switch (_that) {
case _VideoJobResponse() when $default != null:
return $default(_that.videoId,_that.id,_that.taskId,_that.status,_that.state,_that.progress,_that.percent,_that.progressPercent,_that.url,_that.videoUrl,_that.videoUrlCamel,_that.error,_that.message,_that.seconds,_that.size,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _VideoJobResponse extends VideoJobResponse {
  const _VideoJobResponse({@JsonKey(name: 'video_id') this.videoId, this.id, @JsonKey(name: 'task_id') this.taskId, this.status, this.state, this.progress, this.percent, @JsonKey(name: 'progress_percent') this.progressPercent, this.url, @JsonKey(name: 'video_url') this.videoUrl, @JsonKey(name: 'videoUrl') this.videoUrlCamel, this.error, this.message, this.seconds, this.size, this.metadata}): super(videoId: videoId, id: id, taskId: taskId, status: status, state: state, progress: progress, percent: percent, progressPercent: progressPercent, url: url, videoUrl: videoUrl, videoUrlCamel: videoUrlCamel, error: error, message: message, seconds: seconds, size: size, metadata: metadata);
  factory _VideoJobResponse.fromJson(Map<String, dynamic> json) => _$VideoJobResponseFromJson(json);

@override@JsonKey(name: 'video_id') final  String? videoId;
@override final  String? id;
@override@JsonKey(name: 'task_id') final  String? taskId;
@override final  String? status;
@override final  String? state;
@override final  num? progress;
@override final  num? percent;
@override@JsonKey(name: 'progress_percent') final  num? progressPercent;
@override final  String? url;
@override@JsonKey(name: 'video_url') final  String? videoUrl;
@override@JsonKey(name: 'videoUrl') final  String? videoUrlCamel;
@override final  String? error;
@override final  String? message;
@override final  num? seconds;
@override final  String? size;
@override final  VideoMetadata? metadata;

/// Create a copy of VideoJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoJobResponseCopyWith<_VideoJobResponse> get copyWith => __$VideoJobResponseCopyWithImpl<_VideoJobResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoJobResponse&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.status, status) || other.status == status)&&(identical(other.state, state) || other.state == state)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.url, url) || other.url == url)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.videoUrlCamel, videoUrlCamel) || other.videoUrlCamel == videoUrlCamel)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.size, size) || other.size == size)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,videoId,id,taskId,status,state,progress,percent,progressPercent,url,videoUrl,videoUrlCamel,error,message,seconds,size,metadata);
}

@override
String toString() {
    return 'VideoJobResponse(videoId: $videoId, id: $id, taskId: $taskId, status: $status, state: $state, progress: $progress, percent: $percent, progressPercent: $progressPercent, url: $url, videoUrl: $videoUrl, videoUrlCamel: $videoUrlCamel, error: $error, message: $message, seconds: $seconds, size: $size, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$VideoJobResponseCopyWith<$Res> implements $VideoJobResponseCopyWith<$Res> {
  factory _$VideoJobResponseCopyWith(_VideoJobResponse value, $Res Function(_VideoJobResponse) _then) = __$VideoJobResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'video_id') String? videoId, String? id,@JsonKey(name: 'task_id') String? taskId, String? status, String? state, num? progress, num? percent,@JsonKey(name: 'progress_percent') num? progressPercent, String? url,@JsonKey(name: 'video_url') String? videoUrl,@JsonKey(name: 'videoUrl') String? videoUrlCamel, String? error, String? message, num? seconds, String? size, VideoMetadata? metadata
});


@override $VideoMetadataCopyWith<$Res>? get metadata;

}
/// @nodoc
class __$VideoJobResponseCopyWithImpl<$Res>
    implements _$VideoJobResponseCopyWith<$Res> {
  __$VideoJobResponseCopyWithImpl(this._self, this._then);

  final _VideoJobResponse _self;
  final $Res Function(_VideoJobResponse) _then;

/// Create a copy of VideoJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? videoId = freezed,Object? id = freezed,Object? taskId = freezed,Object? status = freezed,Object? state = freezed,Object? progress = freezed,Object? percent = freezed,Object? progressPercent = freezed,Object? url = freezed,Object? videoUrl = freezed,Object? videoUrlCamel = freezed,Object? error = freezed,Object? message = freezed,Object? seconds = freezed,Object? size = freezed,Object? metadata = freezed,}) {
  return _then(_VideoJobResponse(
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
 String? url, num? seconds, String? message,@JsonKey(name: 'size_mapping') VideoSizeMapping? sizeMapping
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoMetadata value)  $default,){
final _that = this;
switch (_that) {
case _VideoMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _VideoMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  num? seconds,  String? message, @JsonKey(name: 'size_mapping')  VideoSizeMapping? sizeMapping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoMetadata() when $default != null:
return $default(_that.url,_that.seconds,_that.message,_that.sizeMapping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  num? seconds,  String? message, @JsonKey(name: 'size_mapping')  VideoSizeMapping? sizeMapping)  $default,) {final _that = this;
switch (_that) {
case _VideoMetadata():
return $default(_that.url,_that.seconds,_that.message,_that.sizeMapping);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  num? seconds,  String? message, @JsonKey(name: 'size_mapping')  VideoSizeMapping? sizeMapping)?  $default,) {final _that = this;
switch (_that) {
case _VideoMetadata() when $default != null:
return $default(_that.url,_that.seconds,_that.message,_that.sizeMapping);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _VideoMetadata extends VideoMetadata {
  const _VideoMetadata({this.url, this.seconds, this.message, @JsonKey(name: 'size_mapping') this.sizeMapping}): super(url: url, seconds: seconds, message: message, sizeMapping: sizeMapping);
  factory _VideoMetadata.fromJson(Map<String, dynamic> json) => _$VideoMetadataFromJson(json);

@override final  String? url;
@override final  num? seconds;
@override final  String? message;
@override@JsonKey(name: 'size_mapping') final  VideoSizeMapping? sizeMapping;

/// Create a copy of VideoMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoMetadataCopyWith<_VideoMetadata> get copyWith => __$VideoMetadataCopyWithImpl<_VideoMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoMetadata&&(identical(other.url, url) || other.url == url)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.message, message) || other.message == message)&&(identical(other.sizeMapping, sizeMapping) || other.sizeMapping == sizeMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,seconds,message,sizeMapping);
}

@override
String toString() {
    return 'VideoMetadata(url: $url, seconds: $seconds, message: $message, sizeMapping: $sizeMapping)';
}


}

/// @nodoc
abstract mixin class _$VideoMetadataCopyWith<$Res> implements $VideoMetadataCopyWith<$Res> {
  factory _$VideoMetadataCopyWith(_VideoMetadata value, $Res Function(_VideoMetadata) _then) = __$VideoMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? url, num? seconds, String? message,@JsonKey(name: 'size_mapping') VideoSizeMapping? sizeMapping
});


@override $VideoSizeMappingCopyWith<$Res>? get sizeMapping;

}
/// @nodoc
class __$VideoMetadataCopyWithImpl<$Res>
    implements _$VideoMetadataCopyWith<$Res> {
  __$VideoMetadataCopyWithImpl(this._self, this._then);

  final _VideoMetadata _self;
  final $Res Function(_VideoMetadata) _then;

/// Create a copy of VideoMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? seconds = freezed,Object? message = freezed,Object? sizeMapping = freezed,}) {
  return _then(_VideoMetadata(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoSizeMapping value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoSizeMapping() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoSizeMapping value)  $default,){
final _that = this;
switch (_that) {
case _VideoSizeMapping():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoSizeMapping value)?  $default,){
final _that = this;
switch (_that) {
case _VideoSizeMapping() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'actual_size')  String? actualSize,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoSizeMapping() when $default != null:
return $default(_that.actualSize,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'actual_size')  String? actualSize,  String? message)  $default,) {final _that = this;
switch (_that) {
case _VideoSizeMapping():
return $default(_that.actualSize,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'actual_size')  String? actualSize,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _VideoSizeMapping() when $default != null:
return $default(_that.actualSize,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _VideoSizeMapping extends VideoSizeMapping {
  const _VideoSizeMapping({@JsonKey(name: 'actual_size') this.actualSize, this.message}): super(actualSize: actualSize, message: message);
  factory _VideoSizeMapping.fromJson(Map<String, dynamic> json) => _$VideoSizeMappingFromJson(json);

@override@JsonKey(name: 'actual_size') final  String? actualSize;
@override final  String? message;

/// Create a copy of VideoSizeMapping
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoSizeMappingCopyWith<_VideoSizeMapping> get copyWith => __$VideoSizeMappingCopyWithImpl<_VideoSizeMapping>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoSizeMapping&&(identical(other.actualSize, actualSize) || other.actualSize == actualSize)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,actualSize,message);
}

@override
String toString() {
    return 'VideoSizeMapping(actualSize: $actualSize, message: $message)';
}


}

/// @nodoc
abstract mixin class _$VideoSizeMappingCopyWith<$Res> implements $VideoSizeMappingCopyWith<$Res> {
  factory _$VideoSizeMappingCopyWith(_VideoSizeMapping value, $Res Function(_VideoSizeMapping) _then) = __$VideoSizeMappingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'actual_size') String? actualSize, String? message
});




}
/// @nodoc
class __$VideoSizeMappingCopyWithImpl<$Res>
    implements _$VideoSizeMappingCopyWith<$Res> {
  __$VideoSizeMappingCopyWithImpl(this._self, this._then);

  final _VideoSizeMapping _self;
  final $Res Function(_VideoSizeMapping) _then;

/// Create a copy of VideoSizeMapping
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actualSize = freezed,Object? message = freezed,}) {
  return _then(_VideoSizeMapping(
actualSize: freezed == actualSize ? _self.actualSize : actualSize // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
