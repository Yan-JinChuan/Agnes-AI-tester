// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_catalog_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModelCatalogState {


/// Create a copy of ModelCatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelCatalogStateCopyWith<ModelCatalogState> get copyWith => _$ModelCatalogStateCopyWithImpl<ModelCatalogState>(this as ModelCatalogState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ModelCatalogState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelCatalogState&&const DeepCollectionEquality().equals(other.models, _this.models)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ModelCatalogState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.models),_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as ModelCatalogState;
  return 'ModelCatalogState(models: ${_this.models}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ModelCatalogStateCopyWith<$Res>  {
  factory $ModelCatalogStateCopyWith(ModelCatalogState value, $Res Function(ModelCatalogState) _then) = _$ModelCatalogStateCopyWithImpl;
@useResult
$Res call({
 List<ModelInfo> models, bool isLoading, String? error
});




}
/// @nodoc
class _$ModelCatalogStateCopyWithImpl<$Res>
    implements $ModelCatalogStateCopyWith<$Res> {
  _$ModelCatalogStateCopyWithImpl(this._self, this._then);

  final ModelCatalogState _self;
  final $Res Function(ModelCatalogState) _then;

/// Create a copy of ModelCatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? models = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(ModelCatalogState(
models: null == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<ModelInfo>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



// dart format on
