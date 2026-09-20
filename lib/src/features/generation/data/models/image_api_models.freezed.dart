// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageGenerationRequest {


/// Create a copy of ImageGenerationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationRequestCopyWith<ImageGenerationRequest> get copyWith => _$ImageGenerationRequestCopyWithImpl<ImageGenerationRequest>(this as ImageGenerationRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImageGenerationRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationRequest&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.n, _this.n) || other.n == _this.n)&&const DeepCollectionEquality().equals(other.extraBody, _this.extraBody));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ImageGenerationRequest;
  return Object.hash(runtimeType,_this.model,_this.prompt,_this.size,_this.n,const DeepCollectionEquality().hash(_this.extraBody));
}

@override
String toString() {
  final _this = this as ImageGenerationRequest;
  return 'ImageGenerationRequest(model: ${_this.model}, prompt: ${_this.prompt}, size: ${_this.size}, n: ${_this.n}, extraBody: ${_this.extraBody})';
}


}

/// @nodoc
abstract mixin class $ImageGenerationRequestCopyWith<$Res>  {
  factory $ImageGenerationRequestCopyWith(ImageGenerationRequest value, $Res Function(ImageGenerationRequest) _then) = _$ImageGenerationRequestCopyWithImpl;
@useResult
$Res call({
 String model, String prompt, String size, int n,@JsonKey(name: 'extra_body') Map<String, dynamic>? extraBody
});




}
/// @nodoc
class _$ImageGenerationRequestCopyWithImpl<$Res>
    implements $ImageGenerationRequestCopyWith<$Res> {
  _$ImageGenerationRequestCopyWithImpl(this._self, this._then);

  final ImageGenerationRequest _self;
  final $Res Function(ImageGenerationRequest) _then;

/// Create a copy of ImageGenerationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? prompt = null,Object? size = null,Object? n = null,Object? extraBody = freezed,}) {
  return _then(ImageGenerationRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,extraBody: freezed == extraBody ? _self.extraBody : extraBody // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageGenerationRequest].
extension ImageGenerationRequestPatterns on ImageGenerationRequest {
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
mixin _$ImageGenerationResponse {


/// Create a copy of ImageGenerationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationResponseCopyWith<ImageGenerationResponse> get copyWith => _$ImageGenerationResponseCopyWithImpl<ImageGenerationResponse>(this as ImageGenerationResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImageGenerationResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationResponse&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ImageGenerationResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as ImageGenerationResponse;
  return 'ImageGenerationResponse(data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ImageGenerationResponseCopyWith<$Res>  {
  factory $ImageGenerationResponseCopyWith(ImageGenerationResponse value, $Res Function(ImageGenerationResponse) _then) = _$ImageGenerationResponseCopyWithImpl;
@useResult
$Res call({
 List<ImageData> data
});




}
/// @nodoc
class _$ImageGenerationResponseCopyWithImpl<$Res>
    implements $ImageGenerationResponseCopyWith<$Res> {
  _$ImageGenerationResponseCopyWithImpl(this._self, this._then);

  final ImageGenerationResponse _self;
  final $Res Function(ImageGenerationResponse) _then;

/// Create a copy of ImageGenerationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(ImageGenerationResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ImageData>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageGenerationResponse].
extension ImageGenerationResponsePatterns on ImageGenerationResponse {
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
mixin _$ImageData {


/// Create a copy of ImageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageDataCopyWith<ImageData> get copyWith => _$ImageDataCopyWithImpl<ImageData>(this as ImageData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImageData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageData&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.base64Json, _this.base64Json) || other.base64Json == _this.base64Json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ImageData;
  return Object.hash(runtimeType,_this.url,_this.base64Json);
}

@override
String toString() {
  final _this = this as ImageData;
  return 'ImageData(url: ${_this.url}, base64Json: ${_this.base64Json})';
}


}

/// @nodoc
abstract mixin class $ImageDataCopyWith<$Res>  {
  factory $ImageDataCopyWith(ImageData value, $Res Function(ImageData) _then) = _$ImageDataCopyWithImpl;
@useResult
$Res call({
 String? url,@JsonKey(name: 'b64_json') String? base64Json
});




}
/// @nodoc
class _$ImageDataCopyWithImpl<$Res>
    implements $ImageDataCopyWith<$Res> {
  _$ImageDataCopyWithImpl(this._self, this._then);

  final ImageData _self;
  final $Res Function(ImageData) _then;

/// Create a copy of ImageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? base64Json = freezed,}) {
  return _then(ImageData(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,base64Json: freezed == base64Json ? _self.base64Json : base64Json // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageData].
extension ImageDataPatterns on ImageData {
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
