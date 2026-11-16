// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_lifecycle_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppLifecycleSnapshot {


/// Create a copy of AppLifecycleSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLifecycleSnapshotCopyWith<AppLifecycleSnapshot> get copyWith => _$AppLifecycleSnapshotCopyWithImpl<AppLifecycleSnapshot>(this as AppLifecycleSnapshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppLifecycleSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLifecycleSnapshot&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.memoryPressureRevision, _this.memoryPressureRevision) || other.memoryPressureRevision == _this.memoryPressureRevision));
}


@override
int get hashCode {
  final _this = this as AppLifecycleSnapshot;
  return Object.hash(runtimeType,_this.state,_this.memoryPressureRevision);
}

@override
String toString() {
  final _this = this as AppLifecycleSnapshot;
  return 'AppLifecycleSnapshot(state: ${_this.state}, memoryPressureRevision: ${_this.memoryPressureRevision})';
}


}

/// @nodoc
abstract mixin class $AppLifecycleSnapshotCopyWith<$Res>  {
  factory $AppLifecycleSnapshotCopyWith(AppLifecycleSnapshot value, $Res Function(AppLifecycleSnapshot) _then) = _$AppLifecycleSnapshotCopyWithImpl;
@useResult
$Res call({
 AppLifecycleState state, int memoryPressureRevision
});




}
/// @nodoc
class _$AppLifecycleSnapshotCopyWithImpl<$Res>
    implements $AppLifecycleSnapshotCopyWith<$Res> {
  _$AppLifecycleSnapshotCopyWithImpl(this._self, this._then);

  final AppLifecycleSnapshot _self;
  final $Res Function(AppLifecycleSnapshot) _then;

/// Create a copy of AppLifecycleSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? memoryPressureRevision = null,}) {
  return _then(AppLifecycleSnapshot(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as AppLifecycleState,memoryPressureRevision: null == memoryPressureRevision ? _self.memoryPressureRevision : memoryPressureRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



// dart format on
