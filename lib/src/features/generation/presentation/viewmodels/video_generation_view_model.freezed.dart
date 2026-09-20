// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_generation_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoState {


/// Create a copy of VideoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoStateCopyWith<VideoState> get copyWith => _$VideoStateCopyWithImpl<VideoState>(this as VideoState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoState&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.dimensionPreset, _this.dimensionPreset) || other.dimensionPreset == _this.dimensionPreset)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.numFrames, _this.numFrames) || other.numFrames == _this.numFrames)&&(identical(other.frameRate, _this.frameRate) || other.frameRate == _this.frameRate)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.keyframeUrls, _this.keyframeUrls) || other.keyframeUrls == _this.keyframeUrls)&&(identical(other.numInferenceSteps, _this.numInferenceSteps) || other.numInferenceSteps == _this.numInferenceSteps)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&(identical(other.negativePrompt, _this.negativePrompt) || other.negativePrompt == _this.negativePrompt)&&(identical(other.job, _this.job) || other.job == _this.job)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as VideoState;
  return Object.hash(runtimeType,_this.prompt,_this.dimensionPreset,_this.width,_this.height,_this.numFrames,_this.frameRate,_this.mode,_this.imageUrl,_this.keyframeUrls,_this.numInferenceSteps,_this.seed,_this.negativePrompt,_this.job,const DeepCollectionEquality().hash(_this.history),_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as VideoState;
  return 'VideoState(prompt: ${_this.prompt}, dimensionPreset: ${_this.dimensionPreset}, width: ${_this.width}, height: ${_this.height}, numFrames: ${_this.numFrames}, frameRate: ${_this.frameRate}, mode: ${_this.mode}, imageUrl: ${_this.imageUrl}, keyframeUrls: ${_this.keyframeUrls}, numInferenceSteps: ${_this.numInferenceSteps}, seed: ${_this.seed}, negativePrompt: ${_this.negativePrompt}, job: ${_this.job}, history: ${_this.history}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $VideoStateCopyWith<$Res>  {
  factory $VideoStateCopyWith(VideoState value, $Res Function(VideoState) _then) = _$VideoStateCopyWithImpl;
@useResult
$Res call({
 String prompt, String dimensionPreset, String width, String height, String numFrames, String frameRate, String mode, String imageUrl, String keyframeUrls, String numInferenceSteps, String seed, String negativePrompt, VideoJob? job, List<VideoGenerationRecord> history, bool isLoading, String? error
});




}
/// @nodoc
class _$VideoStateCopyWithImpl<$Res>
    implements $VideoStateCopyWith<$Res> {
  _$VideoStateCopyWithImpl(this._self, this._then);

  final VideoState _self;
  final $Res Function(VideoState) _then;

/// Create a copy of VideoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prompt = null,Object? dimensionPreset = null,Object? width = null,Object? height = null,Object? numFrames = null,Object? frameRate = null,Object? mode = null,Object? imageUrl = null,Object? keyframeUrls = null,Object? numInferenceSteps = null,Object? seed = null,Object? negativePrompt = null,Object? job = freezed,Object? history = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(VideoState(
prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,dimensionPreset: null == dimensionPreset ? _self.dimensionPreset : dimensionPreset // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String,numFrames: null == numFrames ? _self.numFrames : numFrames // ignore: cast_nullable_to_non_nullable
as String,frameRate: null == frameRate ? _self.frameRate : frameRate // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,keyframeUrls: null == keyframeUrls ? _self.keyframeUrls : keyframeUrls // ignore: cast_nullable_to_non_nullable
as String,numInferenceSteps: null == numInferenceSteps ? _self.numInferenceSteps : numInferenceSteps // ignore: cast_nullable_to_non_nullable
as String,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as String,negativePrompt: null == negativePrompt ? _self.negativePrompt : negativePrompt // ignore: cast_nullable_to_non_nullable
as String,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as VideoJob?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<VideoGenerationRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



// dart format on
