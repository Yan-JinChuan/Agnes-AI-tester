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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageGenerationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageGenerationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageGenerationRequest value)  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageGenerationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  String prompt,  String size,  int n, @JsonKey(name: 'extra_body')  Map<String, dynamic>? extraBody)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageGenerationRequest() when $default != null:
return $default(_that.model,_that.prompt,_that.size,_that.n,_that.extraBody);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  String prompt,  String size,  int n, @JsonKey(name: 'extra_body')  Map<String, dynamic>? extraBody)  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationRequest():
return $default(_that.model,_that.prompt,_that.size,_that.n,_that.extraBody);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  String prompt,  String size,  int n, @JsonKey(name: 'extra_body')  Map<String, dynamic>? extraBody)?  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationRequest() when $default != null:
return $default(_that.model,_that.prompt,_that.size,_that.n,_that.extraBody);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ImageGenerationRequest extends ImageGenerationRequest {
   _ImageGenerationRequest({required this.model, required this.prompt, required this.size, this.n = 1, @JsonKey(name: 'extra_body')  Map<String, dynamic>? extraBody}): _extraBody = extraBody,super(model: model, prompt: prompt, size: size, n: n, extraBody: extraBody);
  factory _ImageGenerationRequest.fromJson(Map<String, dynamic> json) => _$ImageGenerationRequestFromJson(json);

@override final  String model;
@override final  String prompt;
@override final  String size;
@override final  int n;
 final  Map<String, dynamic>? _extraBody;
@override@JsonKey(name: 'extra_body') Map<String, dynamic>? get extraBody {
  final value = _extraBody;
  if (value == null) return null;
  if (_extraBody is EqualUnmodifiableMapView) return _extraBody;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ImageGenerationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageGenerationRequestCopyWith<_ImageGenerationRequest> get copyWith => __$ImageGenerationRequestCopyWithImpl<_ImageGenerationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageGenerationRequest&&(identical(other.model, model) || other.model == model)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.size, size) || other.size == size)&&(identical(other.n, n) || other.n == n)&&const DeepCollectionEquality().equals(other.extraBody, _extraBody));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,model,prompt,size,n,const DeepCollectionEquality().hash(_extraBody));
}

@override
String toString() {
    return 'ImageGenerationRequest(model: $model, prompt: $prompt, size: $size, n: $n, extraBody: $extraBody)';
}


}

/// @nodoc
abstract mixin class _$ImageGenerationRequestCopyWith<$Res> implements $ImageGenerationRequestCopyWith<$Res> {
  factory _$ImageGenerationRequestCopyWith(_ImageGenerationRequest value, $Res Function(_ImageGenerationRequest) _then) = __$ImageGenerationRequestCopyWithImpl;
@override @useResult
$Res call({
 String model, String prompt, String size, int n,@JsonKey(name: 'extra_body') Map<String, dynamic>? extraBody
});




}
/// @nodoc
class __$ImageGenerationRequestCopyWithImpl<$Res>
    implements _$ImageGenerationRequestCopyWith<$Res> {
  __$ImageGenerationRequestCopyWithImpl(this._self, this._then);

  final _ImageGenerationRequest _self;
  final $Res Function(_ImageGenerationRequest) _then;

/// Create a copy of ImageGenerationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? prompt = null,Object? size = null,Object? n = null,Object? extraBody = freezed,}) {
  return _then(_ImageGenerationRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,extraBody: freezed == extraBody ? _self._extraBody : extraBody // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageGenerationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageGenerationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageGenerationResponse value)  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageGenerationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ImageData> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageGenerationResponse() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ImageData> data)  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationResponse():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ImageData> data)?  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ImageGenerationResponse extends ImageGenerationResponse {
   _ImageGenerationResponse({ List<ImageData> data = const []}): _data = data,super(data: data);
  factory _ImageGenerationResponse.fromJson(Map<String, dynamic> json) => _$ImageGenerationResponseFromJson(json);

 final  List<ImageData> _data;
@override List<ImageData> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of ImageGenerationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageGenerationResponseCopyWith<_ImageGenerationResponse> get copyWith => __$ImageGenerationResponseCopyWithImpl<_ImageGenerationResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageGenerationResponse&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'ImageGenerationResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ImageGenerationResponseCopyWith<$Res> implements $ImageGenerationResponseCopyWith<$Res> {
  factory _$ImageGenerationResponseCopyWith(_ImageGenerationResponse value, $Res Function(_ImageGenerationResponse) _then) = __$ImageGenerationResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ImageData> data
});




}
/// @nodoc
class __$ImageGenerationResponseCopyWithImpl<$Res>
    implements _$ImageGenerationResponseCopyWith<$Res> {
  __$ImageGenerationResponseCopyWithImpl(this._self, this._then);

  final _ImageGenerationResponse _self;
  final $Res Function(_ImageGenerationResponse) _then;

/// Create a copy of ImageGenerationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ImageGenerationResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ImageData>,
  ));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageData value)  $default,){
final _that = this;
switch (_that) {
case _ImageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageData value)?  $default,){
final _that = this;
switch (_that) {
case _ImageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url, @JsonKey(name: 'b64_json')  String? base64Json)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageData() when $default != null:
return $default(_that.url,_that.base64Json);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url, @JsonKey(name: 'b64_json')  String? base64Json)  $default,) {final _that = this;
switch (_that) {
case _ImageData():
return $default(_that.url,_that.base64Json);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url, @JsonKey(name: 'b64_json')  String? base64Json)?  $default,) {final _that = this;
switch (_that) {
case _ImageData() when $default != null:
return $default(_that.url,_that.base64Json);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ImageData extends ImageData {
   _ImageData({this.url, @JsonKey(name: 'b64_json') this.base64Json}): super(url: url, base64Json: base64Json);
  factory _ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);

@override final  String? url;
@override@JsonKey(name: 'b64_json') final  String? base64Json;

/// Create a copy of ImageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageDataCopyWith<_ImageData> get copyWith => __$ImageDataCopyWithImpl<_ImageData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageData&&(identical(other.url, url) || other.url == url)&&(identical(other.base64Json, base64Json) || other.base64Json == base64Json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,base64Json);
}

@override
String toString() {
    return 'ImageData(url: $url, base64Json: $base64Json)';
}


}

/// @nodoc
abstract mixin class _$ImageDataCopyWith<$Res> implements $ImageDataCopyWith<$Res> {
  factory _$ImageDataCopyWith(_ImageData value, $Res Function(_ImageData) _then) = __$ImageDataCopyWithImpl;
@override @useResult
$Res call({
 String? url,@JsonKey(name: 'b64_json') String? base64Json
});




}
/// @nodoc
class __$ImageDataCopyWithImpl<$Res>
    implements _$ImageDataCopyWith<$Res> {
  __$ImageDataCopyWithImpl(this._self, this._then);

  final _ImageData _self;
  final $Res Function(_ImageData) _then;

/// Create a copy of ImageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? base64Json = freezed,}) {
  return _then(_ImageData(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,base64Json: freezed == base64Json ? _self.base64Json : base64Json // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
