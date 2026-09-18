// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_catalog_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModelCatalogResponse {


/// Create a copy of ModelCatalogResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelCatalogResponseCopyWith<ModelCatalogResponse> get copyWith => _$ModelCatalogResponseCopyWithImpl<ModelCatalogResponse>(this as ModelCatalogResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ModelCatalogResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelCatalogResponse&&const DeepCollectionEquality().equals(other.data, _this.data)&&const DeepCollectionEquality().equals(other.models, _this.models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ModelCatalogResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),const DeepCollectionEquality().hash(_this.models));
}

@override
String toString() {
  final _this = this as ModelCatalogResponse;
  return 'ModelCatalogResponse(data: ${_this.data}, models: ${_this.models})';
}


}

/// @nodoc
abstract mixin class $ModelCatalogResponseCopyWith<$Res>  {
  factory $ModelCatalogResponseCopyWith(ModelCatalogResponse value, $Res Function(ModelCatalogResponse) _then) = _$ModelCatalogResponseCopyWithImpl;
@useResult
$Res call({
 List<Object?>? data, List<Object?>? models
});




}
/// @nodoc
class _$ModelCatalogResponseCopyWithImpl<$Res>
    implements $ModelCatalogResponseCopyWith<$Res> {
  _$ModelCatalogResponseCopyWithImpl(this._self, this._then);

  final ModelCatalogResponse _self;
  final $Res Function(ModelCatalogResponse) _then;

/// Create a copy of ModelCatalogResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? models = freezed,}) {
  return _then(ModelCatalogResponse(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<Object?>?,models: freezed == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<Object?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelCatalogResponse].
extension ModelCatalogResponsePatterns on ModelCatalogResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelCatalogResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelCatalogResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelCatalogResponse value)  $default,){
final _that = this;
switch (_that) {
case _ModelCatalogResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelCatalogResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ModelCatalogResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Object?>? data,  List<Object?>? models)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelCatalogResponse() when $default != null:
return $default(_that.data,_that.models);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Object?>? data,  List<Object?>? models)  $default,) {final _that = this;
switch (_that) {
case _ModelCatalogResponse():
return $default(_that.data,_that.models);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Object?>? data,  List<Object?>? models)?  $default,) {final _that = this;
switch (_that) {
case _ModelCatalogResponse() when $default != null:
return $default(_that.data,_that.models);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ModelCatalogResponse extends ModelCatalogResponse {
  const _ModelCatalogResponse({ List<Object?>? data,  List<Object?>? models}): _data = data,_models = models,super(data: data, models: models);
  factory _ModelCatalogResponse.fromJson(Map<String, dynamic> json) => _$ModelCatalogResponseFromJson(json);

 final  List<Object?>? _data;
@override List<Object?>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Object?>? _models;
@override List<Object?>? get models {
  final value = _models;
  if (value == null) return null;
  if (_models is EqualUnmodifiableListView) return _models;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ModelCatalogResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelCatalogResponseCopyWith<_ModelCatalogResponse> get copyWith => __$ModelCatalogResponseCopyWithImpl<_ModelCatalogResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelCatalogResponse&&const DeepCollectionEquality().equals(other.data, _data)&&const DeepCollectionEquality().equals(other.models, _models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(_models));
}

@override
String toString() {
    return 'ModelCatalogResponse(data: $data, models: $models)';
}


}

/// @nodoc
abstract mixin class _$ModelCatalogResponseCopyWith<$Res> implements $ModelCatalogResponseCopyWith<$Res> {
  factory _$ModelCatalogResponseCopyWith(_ModelCatalogResponse value, $Res Function(_ModelCatalogResponse) _then) = __$ModelCatalogResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Object?>? data, List<Object?>? models
});




}
/// @nodoc
class __$ModelCatalogResponseCopyWithImpl<$Res>
    implements _$ModelCatalogResponseCopyWith<$Res> {
  __$ModelCatalogResponseCopyWithImpl(this._self, this._then);

  final _ModelCatalogResponse _self;
  final $Res Function(_ModelCatalogResponse) _then;

/// Create a copy of ModelCatalogResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? models = freezed,}) {
  return _then(_ModelCatalogResponse(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Object?>?,models: freezed == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<Object?>?,
  ));
}


}

// dart format on
