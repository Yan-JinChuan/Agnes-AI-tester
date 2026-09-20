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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoState&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.dimensionPreset, _this.dimensionPreset) || other.dimensionPreset == _this.dimensionPreset)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.numFrames, _this.numFrames) || other.numFrames == _this.numFrames)&&(identical(other.frameRate, _this.frameRate) || other.frameRate == _this.frameRate)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.keyframeUrls, _this.keyframeUrls) || other.keyframeUrls == _this.keyframeUrls)&&(identical(other.numInferenceSteps, _this.numInferenceSteps) || other.numInferenceSteps == _this.numInferenceSteps)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&(identical(other.negativePrompt, _this.negativePrompt) || other.negativePrompt == _this.negativePrompt)&&(identical(other.seconds, _this.seconds) || other.seconds == _this.seconds)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.aspectRatio, _this.aspectRatio) || other.aspectRatio == _this.aspectRatio)&&(identical(other.firstFrame, _this.firstFrame) || other.firstFrame == _this.firstFrame)&&(identical(other.lastFrame, _this.lastFrame) || other.lastFrame == _this.lastFrame)&&(identical(other.imageUrls, _this.imageUrls) || other.imageUrls == _this.imageUrls)&&(identical(other.audioUrls, _this.audioUrls) || other.audioUrls == _this.audioUrls)&&(identical(other.referenceVideoUrl, _this.referenceVideoUrl) || other.referenceVideoUrl == _this.referenceVideoUrl)&&(identical(other.referenceVideoStartSeconds, _this.referenceVideoStartSeconds) || other.referenceVideoStartSeconds == _this.referenceVideoStartSeconds)&&(identical(other.referenceVideoRequireAudio, _this.referenceVideoRequireAudio) || other.referenceVideoRequireAudio == _this.referenceVideoRequireAudio)&&(identical(other.job, _this.job) || other.job == _this.job)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as VideoState;
  return Object.hashAll([runtimeType,_this.prompt,_this.dimensionPreset,_this.width,_this.height,_this.numFrames,_this.frameRate,_this.mode,_this.imageUrl,_this.keyframeUrls,_this.numInferenceSteps,_this.seed,_this.negativePrompt,_this.seconds,_this.size,_this.aspectRatio,_this.firstFrame,_this.lastFrame,_this.imageUrls,_this.audioUrls,_this.referenceVideoUrl,_this.referenceVideoStartSeconds,_this.referenceVideoRequireAudio,_this.job,const DeepCollectionEquality().hash(_this.history),_this.isLoading,_this.error]);
}

@override
String toString() {
  final _this = this as VideoState;
  return 'VideoState(prompt: ${_this.prompt}, dimensionPreset: ${_this.dimensionPreset}, width: ${_this.width}, height: ${_this.height}, numFrames: ${_this.numFrames}, frameRate: ${_this.frameRate}, mode: ${_this.mode}, imageUrl: ${_this.imageUrl}, keyframeUrls: ${_this.keyframeUrls}, numInferenceSteps: ${_this.numInferenceSteps}, seed: ${_this.seed}, negativePrompt: ${_this.negativePrompt}, seconds: ${_this.seconds}, size: ${_this.size}, aspectRatio: ${_this.aspectRatio}, firstFrame: ${_this.firstFrame}, lastFrame: ${_this.lastFrame}, imageUrls: ${_this.imageUrls}, audioUrls: ${_this.audioUrls}, referenceVideoUrl: ${_this.referenceVideoUrl}, referenceVideoStartSeconds: ${_this.referenceVideoStartSeconds}, referenceVideoRequireAudio: ${_this.referenceVideoRequireAudio}, job: ${_this.job}, history: ${_this.history}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $VideoStateCopyWith<$Res>  {
  factory $VideoStateCopyWith(VideoState value, $Res Function(VideoState) _then) = _$VideoStateCopyWithImpl;
@useResult
$Res call({
 String prompt, String dimensionPreset, String width, String height, String numFrames, String frameRate, String mode, String imageUrl, String keyframeUrls, String numInferenceSteps, String seed, String negativePrompt, String seconds, String size, String aspectRatio, String firstFrame, String lastFrame, String imageUrls, String audioUrls, String referenceVideoUrl, String referenceVideoStartSeconds, bool referenceVideoRequireAudio, VideoJob? job, List<VideoGenerationRecord> history, bool isLoading, String? error
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
@pragma('vm:prefer-inline') @override $Res call({Object? prompt = null,Object? dimensionPreset = null,Object? width = null,Object? height = null,Object? numFrames = null,Object? frameRate = null,Object? mode = null,Object? imageUrl = null,Object? keyframeUrls = null,Object? numInferenceSteps = null,Object? seed = null,Object? negativePrompt = null,Object? seconds = null,Object? size = null,Object? aspectRatio = null,Object? firstFrame = null,Object? lastFrame = null,Object? imageUrls = null,Object? audioUrls = null,Object? referenceVideoUrl = null,Object? referenceVideoStartSeconds = null,Object? referenceVideoRequireAudio = null,Object? job = freezed,Object? history = null,Object? isLoading = null,Object? error = freezed,}) {
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
as String,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String,firstFrame: null == firstFrame ? _self.firstFrame : firstFrame // ignore: cast_nullable_to_non_nullable
as String,lastFrame: null == lastFrame ? _self.lastFrame : lastFrame // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as String,audioUrls: null == audioUrls ? _self.audioUrls : audioUrls // ignore: cast_nullable_to_non_nullable
as String,referenceVideoUrl: null == referenceVideoUrl ? _self.referenceVideoUrl : referenceVideoUrl // ignore: cast_nullable_to_non_nullable
as String,referenceVideoStartSeconds: null == referenceVideoStartSeconds ? _self.referenceVideoStartSeconds : referenceVideoStartSeconds // ignore: cast_nullable_to_non_nullable
as String,referenceVideoRequireAudio: null == referenceVideoRequireAudio ? _self.referenceVideoRequireAudio : referenceVideoRequireAudio // ignore: cast_nullable_to_non_nullable
as bool,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as VideoJob?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<VideoGenerationRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



// dart format on
