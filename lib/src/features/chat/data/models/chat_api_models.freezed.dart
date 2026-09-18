// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatCompletionRequest {


/// Create a copy of ChatCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionRequestCopyWith<ChatCompletionRequest> get copyWith => _$ChatCompletionRequestCopyWithImpl<ChatCompletionRequest>(this as ChatCompletionRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatCompletionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletionRequest&&(identical(other.model, _this.model) || other.model == _this.model)&&const DeepCollectionEquality().equals(other.messages, _this.messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatCompletionRequest;
  return Object.hash(runtimeType,_this.model,const DeepCollectionEquality().hash(_this.messages));
}

@override
String toString() {
  final _this = this as ChatCompletionRequest;
  return 'ChatCompletionRequest(model: ${_this.model}, messages: ${_this.messages})';
}


}

/// @nodoc
abstract mixin class $ChatCompletionRequestCopyWith<$Res>  {
  factory $ChatCompletionRequestCopyWith(ChatCompletionRequest value, $Res Function(ChatCompletionRequest) _then) = _$ChatCompletionRequestCopyWithImpl;
@useResult
$Res call({
 String model, List<ChatMessagePayload> messages
});




}
/// @nodoc
class _$ChatCompletionRequestCopyWithImpl<$Res>
    implements $ChatCompletionRequestCopyWith<$Res> {
  _$ChatCompletionRequestCopyWithImpl(this._self, this._then);

  final ChatCompletionRequest _self;
  final $Res Function(ChatCompletionRequest) _then;

/// Create a copy of ChatCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? messages = null,}) {
  return _then(ChatCompletionRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessagePayload>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatCompletionRequest].
extension ChatCompletionRequestPatterns on ChatCompletionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCompletionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCompletionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCompletionRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCompletionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  List<ChatMessagePayload> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCompletionRequest() when $default != null:
return $default(_that.model,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  List<ChatMessagePayload> messages)  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionRequest():
return $default(_that.model,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  List<ChatMessagePayload> messages)?  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionRequest() when $default != null:
return $default(_that.model,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatCompletionRequest extends ChatCompletionRequest {
   _ChatCompletionRequest({required this.model, required  List<ChatMessagePayload> messages}): _messages = messages,super(model: model, messages: messages);
  factory _ChatCompletionRequest.fromJson(Map<String, dynamic> json) => _$ChatCompletionRequestFromJson(json);

@override final  String model;
 final  List<ChatMessagePayload> _messages;
@override List<ChatMessagePayload> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionRequestCopyWith<_ChatCompletionRequest> get copyWith => __$ChatCompletionRequestCopyWithImpl<_ChatCompletionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletionRequest&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,model,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'ChatCompletionRequest(model: $model, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionRequestCopyWith<$Res> implements $ChatCompletionRequestCopyWith<$Res> {
  factory _$ChatCompletionRequestCopyWith(_ChatCompletionRequest value, $Res Function(_ChatCompletionRequest) _then) = __$ChatCompletionRequestCopyWithImpl;
@override @useResult
$Res call({
 String model, List<ChatMessagePayload> messages
});




}
/// @nodoc
class __$ChatCompletionRequestCopyWithImpl<$Res>
    implements _$ChatCompletionRequestCopyWith<$Res> {
  __$ChatCompletionRequestCopyWithImpl(this._self, this._then);

  final _ChatCompletionRequest _self;
  final $Res Function(_ChatCompletionRequest) _then;

/// Create a copy of ChatCompletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? messages = null,}) {
  return _then(_ChatCompletionRequest(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessagePayload>,
  ));
}


}


/// @nodoc
mixin _$ChatMessagePayload {


/// Create a copy of ChatMessagePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessagePayloadCopyWith<ChatMessagePayload> get copyWith => _$ChatMessagePayloadCopyWithImpl<ChatMessagePayload>(this as ChatMessagePayload, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatMessagePayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessagePayload&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.content, _this.content) || other.content == _this.content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessagePayload;
  return Object.hash(runtimeType,_this.role,_this.content);
}

@override
String toString() {
  final _this = this as ChatMessagePayload;
  return 'ChatMessagePayload(role: ${_this.role}, content: ${_this.content})';
}


}

/// @nodoc
abstract mixin class $ChatMessagePayloadCopyWith<$Res>  {
  factory $ChatMessagePayloadCopyWith(ChatMessagePayload value, $Res Function(ChatMessagePayload) _then) = _$ChatMessagePayloadCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$ChatMessagePayloadCopyWithImpl<$Res>
    implements $ChatMessagePayloadCopyWith<$Res> {
  _$ChatMessagePayloadCopyWithImpl(this._self, this._then);

  final ChatMessagePayload _self;
  final $Res Function(ChatMessagePayload) _then;

/// Create a copy of ChatMessagePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(ChatMessagePayload(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessagePayload].
extension ChatMessagePayloadPatterns on ChatMessagePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessagePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessagePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessagePayload value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessagePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessagePayload value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessagePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessagePayload() when $default != null:
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String content)  $default,) {final _that = this;
switch (_that) {
case _ChatMessagePayload():
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String content)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessagePayload() when $default != null:
return $default(_that.role,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatMessagePayload extends ChatMessagePayload {
   _ChatMessagePayload({required this.role, required this.content}): super(role: role, content: content);
  factory _ChatMessagePayload.fromJson(Map<String, dynamic> json) => _$ChatMessagePayloadFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of ChatMessagePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessagePayloadCopyWith<_ChatMessagePayload> get copyWith => __$ChatMessagePayloadCopyWithImpl<_ChatMessagePayload>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessagePayload&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,role,content);
}

@override
String toString() {
    return 'ChatMessagePayload(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ChatMessagePayloadCopyWith<$Res> implements $ChatMessagePayloadCopyWith<$Res> {
  factory _$ChatMessagePayloadCopyWith(_ChatMessagePayload value, $Res Function(_ChatMessagePayload) _then) = __$ChatMessagePayloadCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$ChatMessagePayloadCopyWithImpl<$Res>
    implements _$ChatMessagePayloadCopyWith<$Res> {
  __$ChatMessagePayloadCopyWithImpl(this._self, this._then);

  final _ChatMessagePayload _self;
  final $Res Function(_ChatMessagePayload) _then;

/// Create a copy of ChatMessagePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_ChatMessagePayload(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatCompletionResponse {


/// Create a copy of ChatCompletionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionResponseCopyWith<ChatCompletionResponse> get copyWith => _$ChatCompletionResponseCopyWithImpl<ChatCompletionResponse>(this as ChatCompletionResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatCompletionResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletionResponse&&const DeepCollectionEquality().equals(other.choices, _this.choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatCompletionResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.choices));
}

@override
String toString() {
  final _this = this as ChatCompletionResponse;
  return 'ChatCompletionResponse(choices: ${_this.choices})';
}


}

/// @nodoc
abstract mixin class $ChatCompletionResponseCopyWith<$Res>  {
  factory $ChatCompletionResponseCopyWith(ChatCompletionResponse value, $Res Function(ChatCompletionResponse) _then) = _$ChatCompletionResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatCompletionChoice> choices
});




}
/// @nodoc
class _$ChatCompletionResponseCopyWithImpl<$Res>
    implements $ChatCompletionResponseCopyWith<$Res> {
  _$ChatCompletionResponseCopyWithImpl(this._self, this._then);

  final ChatCompletionResponse _self;
  final $Res Function(ChatCompletionResponse) _then;

/// Create a copy of ChatCompletionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choices = null,}) {
  return _then(ChatCompletionResponse(
choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<ChatCompletionChoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatCompletionResponse].
extension ChatCompletionResponsePatterns on ChatCompletionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCompletionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCompletionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCompletionResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCompletionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatCompletionChoice> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCompletionResponse() when $default != null:
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatCompletionChoice> choices)  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionResponse():
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatCompletionChoice> choices)?  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionResponse() when $default != null:
return $default(_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatCompletionResponse extends ChatCompletionResponse {
   _ChatCompletionResponse({ List<ChatCompletionChoice> choices = const []}): _choices = choices,super(choices: choices);
  factory _ChatCompletionResponse.fromJson(Map<String, dynamic> json) => _$ChatCompletionResponseFromJson(json);

 final  List<ChatCompletionChoice> _choices;
@override List<ChatCompletionChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of ChatCompletionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionResponseCopyWith<_ChatCompletionResponse> get copyWith => __$ChatCompletionResponseCopyWithImpl<_ChatCompletionResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletionResponse&&const DeepCollectionEquality().equals(other.choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_choices));
}

@override
String toString() {
    return 'ChatCompletionResponse(choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionResponseCopyWith<$Res> implements $ChatCompletionResponseCopyWith<$Res> {
  factory _$ChatCompletionResponseCopyWith(_ChatCompletionResponse value, $Res Function(_ChatCompletionResponse) _then) = __$ChatCompletionResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatCompletionChoice> choices
});




}
/// @nodoc
class __$ChatCompletionResponseCopyWithImpl<$Res>
    implements _$ChatCompletionResponseCopyWith<$Res> {
  __$ChatCompletionResponseCopyWithImpl(this._self, this._then);

  final _ChatCompletionResponse _self;
  final $Res Function(_ChatCompletionResponse) _then;

/// Create a copy of ChatCompletionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choices = null,}) {
  return _then(_ChatCompletionResponse(
choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<ChatCompletionChoice>,
  ));
}


}


/// @nodoc
mixin _$ChatCompletionChoice {


/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionChoiceCopyWith<ChatCompletionChoice> get copyWith => _$ChatCompletionChoiceCopyWithImpl<ChatCompletionChoice>(this as ChatCompletionChoice, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatCompletionChoice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletionChoice&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatCompletionChoice;
  return Object.hash(runtimeType,_this.message);
}

@override
String toString() {
  final _this = this as ChatCompletionChoice;
  return 'ChatCompletionChoice(message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ChatCompletionChoiceCopyWith<$Res>  {
  factory $ChatCompletionChoiceCopyWith(ChatCompletionChoice value, $Res Function(ChatCompletionChoice) _then) = _$ChatCompletionChoiceCopyWithImpl;
@useResult
$Res call({
 ChatCompletionMessage? message
});


$ChatCompletionMessageCopyWith<$Res>? get message;

}
/// @nodoc
class _$ChatCompletionChoiceCopyWithImpl<$Res>
    implements $ChatCompletionChoiceCopyWith<$Res> {
  _$ChatCompletionChoiceCopyWithImpl(this._self, this._then);

  final ChatCompletionChoice _self;
  final $Res Function(ChatCompletionChoice) _then;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,}) {
  return _then(ChatCompletionChoice(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatCompletionMessage?,
  ));
}
/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatCompletionMessageCopyWith<$Res>? get message {
    if (_self.message == null) {
    return null;
  }

  return $ChatCompletionMessageCopyWith<$Res>(_self.message!, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatCompletionChoice].
extension ChatCompletionChoicePatterns on ChatCompletionChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCompletionChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCompletionChoice value)  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCompletionChoice value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatCompletionMessage? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
return $default(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatCompletionMessage? message)  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionChoice():
return $default(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatCompletionMessage? message)?  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
return $default(_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatCompletionChoice extends ChatCompletionChoice {
   _ChatCompletionChoice({this.message}): super(message: message);
  factory _ChatCompletionChoice.fromJson(Map<String, dynamic> json) => _$ChatCompletionChoiceFromJson(json);

@override final  ChatCompletionMessage? message;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionChoiceCopyWith<_ChatCompletionChoice> get copyWith => __$ChatCompletionChoiceCopyWithImpl<_ChatCompletionChoice>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletionChoice&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ChatCompletionChoice(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionChoiceCopyWith<$Res> implements $ChatCompletionChoiceCopyWith<$Res> {
  factory _$ChatCompletionChoiceCopyWith(_ChatCompletionChoice value, $Res Function(_ChatCompletionChoice) _then) = __$ChatCompletionChoiceCopyWithImpl;
@override @useResult
$Res call({
 ChatCompletionMessage? message
});


@override $ChatCompletionMessageCopyWith<$Res>? get message;

}
/// @nodoc
class __$ChatCompletionChoiceCopyWithImpl<$Res>
    implements _$ChatCompletionChoiceCopyWith<$Res> {
  __$ChatCompletionChoiceCopyWithImpl(this._self, this._then);

  final _ChatCompletionChoice _self;
  final $Res Function(_ChatCompletionChoice) _then;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ChatCompletionChoice(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatCompletionMessage?,
  ));
}

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatCompletionMessageCopyWith<$Res>? get message {
    if (_self.message == null) {
    return null;
  }

  return $ChatCompletionMessageCopyWith<$Res>(_self.message!, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// @nodoc
mixin _$ChatCompletionMessage {


/// Create a copy of ChatCompletionMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionMessageCopyWith<ChatCompletionMessage> get copyWith => _$ChatCompletionMessageCopyWithImpl<ChatCompletionMessage>(this as ChatCompletionMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatCompletionMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletionMessage&&const DeepCollectionEquality().equals(other.content, _this.content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatCompletionMessage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.content));
}

@override
String toString() {
  final _this = this as ChatCompletionMessage;
  return 'ChatCompletionMessage(content: ${_this.content})';
}


}

/// @nodoc
abstract mixin class $ChatCompletionMessageCopyWith<$Res>  {
  factory $ChatCompletionMessageCopyWith(ChatCompletionMessage value, $Res Function(ChatCompletionMessage) _then) = _$ChatCompletionMessageCopyWithImpl;
@useResult
$Res call({
 Object? content
});




}
/// @nodoc
class _$ChatCompletionMessageCopyWithImpl<$Res>
    implements $ChatCompletionMessageCopyWith<$Res> {
  _$ChatCompletionMessageCopyWithImpl(this._self, this._then);

  final ChatCompletionMessage _self;
  final $Res Function(ChatCompletionMessage) _then;

/// Create a copy of ChatCompletionMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,}) {
  return _then(ChatCompletionMessage(
content: freezed == content ? _self.content : content ,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatCompletionMessage].
extension ChatCompletionMessagePatterns on ChatCompletionMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCompletionMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCompletionMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCompletionMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCompletionMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCompletionMessage() when $default != null:
return $default(_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object? content)  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionMessage():
return $default(_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object? content)?  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionMessage() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatCompletionMessage extends ChatCompletionMessage {
   _ChatCompletionMessage({this.content}): super(content: content);
  factory _ChatCompletionMessage.fromJson(Map<String, dynamic> json) => _$ChatCompletionMessageFromJson(json);

@override final  Object? content;

/// Create a copy of ChatCompletionMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionMessageCopyWith<_ChatCompletionMessage> get copyWith => __$ChatCompletionMessageCopyWithImpl<_ChatCompletionMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletionMessage&&const DeepCollectionEquality().equals(other.content, content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(content));
}

@override
String toString() {
    return 'ChatCompletionMessage(content: $content)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionMessageCopyWith<$Res> implements $ChatCompletionMessageCopyWith<$Res> {
  factory _$ChatCompletionMessageCopyWith(_ChatCompletionMessage value, $Res Function(_ChatCompletionMessage) _then) = __$ChatCompletionMessageCopyWithImpl;
@override @useResult
$Res call({
 Object? content
});




}
/// @nodoc
class __$ChatCompletionMessageCopyWithImpl<$Res>
    implements _$ChatCompletionMessageCopyWith<$Res> {
  __$ChatCompletionMessageCopyWithImpl(this._self, this._then);

  final _ChatCompletionMessage _self;
  final $Res Function(_ChatCompletionMessage) _then;

/// Create a copy of ChatCompletionMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,}) {
  return _then(_ChatCompletionMessage(
content: freezed == content ? _self.content : content ,
  ));
}


}

// dart format on
