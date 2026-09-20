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



// dart format on
