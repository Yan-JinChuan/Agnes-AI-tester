// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_generation_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageState {


/// Create a copy of ImageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageStateCopyWith<ImageState> get copyWith => _$ImageStateCopyWithImpl<ImageState>(this as ImageState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImageState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageState&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.result, _this.result) || other.result == _this.result)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ImageState;
  return Object.hash(runtimeType,_this.prompt,_this.size,_this.result,const DeepCollectionEquality().hash(_this.history),_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as ImageState;
  return 'ImageState(prompt: ${_this.prompt}, size: ${_this.size}, result: ${_this.result}, history: ${_this.history}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ImageStateCopyWith<$Res>  {
  factory $ImageStateCopyWith(ImageState value, $Res Function(ImageState) _then) = _$ImageStateCopyWithImpl;
@useResult
$Res call({
 String prompt, String size, ImageGenerationRecord? result, List<ImageGenerationRecord> history, bool isLoading, String? error
});




}
/// @nodoc
class _$ImageStateCopyWithImpl<$Res>
    implements $ImageStateCopyWith<$Res> {
  _$ImageStateCopyWithImpl(this._self, this._then);

  final ImageState _self;
  final $Res Function(ImageState) _then;

/// Create a copy of ImageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prompt = null,Object? size = null,Object? result = freezed,Object? history = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(ImageState(
prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ImageGenerationRecord?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<ImageGenerationRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ImageState extends ImageState {
  const _ImageState({this.prompt = '', this.size = '1024x1024', this.result,  List<ImageGenerationRecord> history = const [], this.isLoading = false, this.error}): _history = history,super(prompt: prompt, size: size, result: result, history: history, isLoading: isLoading, error: error);
  

@override final  String prompt;
@override final  String size;
@override final  ImageGenerationRecord? result;
 final  List<ImageGenerationRecord> _history;
@override List<ImageGenerationRecord> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override final  bool isLoading;
@override final  String? error;

/// Create a copy of ImageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageStateCopyWith<_ImageState> get copyWith => __$ImageStateCopyWithImpl<_ImageState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageState&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.size, size) || other.size == size)&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other.history, _history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,prompt,size,result,const DeepCollectionEquality().hash(_history),isLoading,error);
}

@override
String toString() {
    return 'ImageState(prompt: $prompt, size: $size, result: $result, history: $history, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ImageStateCopyWith<$Res> implements $ImageStateCopyWith<$Res> {
  factory _$ImageStateCopyWith(_ImageState value, $Res Function(_ImageState) _then) = __$ImageStateCopyWithImpl;
@override @useResult
$Res call({
 String prompt, String size, ImageGenerationRecord? result, List<ImageGenerationRecord> history, bool isLoading, String? error
});




}
/// @nodoc
class __$ImageStateCopyWithImpl<$Res>
    implements _$ImageStateCopyWith<$Res> {
  __$ImageStateCopyWithImpl(this._self, this._then);

  final _ImageState _self;
  final $Res Function(_ImageState) _then;

/// Create a copy of ImageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prompt = null,Object? size = null,Object? result = freezed,Object? history = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_ImageState(
prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ImageGenerationRecord?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ImageGenerationRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
