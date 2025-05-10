// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get identifier => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String identifier, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String identifier, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.identifier, this.password);

  @override
  final String identifier;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(identifier: $identifier, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identifier, password);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String identifier, final String password) =
      _$LoginObjectImpl;

  @override
  String get identifier;
  @override
  String get password;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  File get image => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {File image,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterObjectImplCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$RegisterObjectImplCopyWith(_$RegisterObjectImpl value,
          $Res Function(_$RegisterObjectImpl) then) =
      __$$RegisterObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {File image,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password});
}

/// @nodoc
class __$$RegisterObjectImplCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$RegisterObjectImpl>
    implements _$$RegisterObjectImplCopyWith<$Res> {
  __$$RegisterObjectImplCopyWithImpl(
      _$RegisterObjectImpl _value, $Res Function(_$RegisterObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? password = null,
  }) {
    return _then(_$RegisterObjectImpl(
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterObjectImpl implements _RegisterObject {
  _$RegisterObjectImpl(this.image, this.firstName, this.lastName, this.email,
      this.phoneNumber, this.password);

  @override
  final File image;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterObject(image: $image, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterObjectImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, image, firstName, lastName, email, phoneNumber, password);

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      __$$RegisterObjectImplCopyWithImpl<_$RegisterObjectImpl>(
          this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      final File image,
      final String firstName,
      final String lastName,
      final String email,
      final String phoneNumber,
      final String password) = _$RegisterObjectImpl;

  @override
  File get image;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get password;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateOrganizerObject {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  File get image => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;

  /// Create a copy of CreateOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateOrganizerObjectCopyWith<CreateOrganizerObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOrganizerObjectCopyWith<$Res> {
  factory $CreateOrganizerObjectCopyWith(CreateOrganizerObject value,
          $Res Function(CreateOrganizerObject) then) =
      _$CreateOrganizerObjectCopyWithImpl<$Res, CreateOrganizerObject>;
  @useResult
  $Res call(
      {String name,
      String type,
      String phoneNumber,
      String description,
      File image,
      String street,
      String city,
      String state,
      String postalCode,
      String imagePath});
}

/// @nodoc
class _$CreateOrganizerObjectCopyWithImpl<$Res,
        $Val extends CreateOrganizerObject>
    implements $CreateOrganizerObjectCopyWith<$Res> {
  _$CreateOrganizerObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? phoneNumber = null,
    Object? description = null,
    Object? image = null,
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? postalCode = null,
    Object? imagePath = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateOrganizerObjectImplCopyWith<$Res>
    implements $CreateOrganizerObjectCopyWith<$Res> {
  factory _$$CreateOrganizerObjectImplCopyWith(
          _$CreateOrganizerObjectImpl value,
          $Res Function(_$CreateOrganizerObjectImpl) then) =
      __$$CreateOrganizerObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      String phoneNumber,
      String description,
      File image,
      String street,
      String city,
      String state,
      String postalCode,
      String imagePath});
}

/// @nodoc
class __$$CreateOrganizerObjectImplCopyWithImpl<$Res>
    extends _$CreateOrganizerObjectCopyWithImpl<$Res,
        _$CreateOrganizerObjectImpl>
    implements _$$CreateOrganizerObjectImplCopyWith<$Res> {
  __$$CreateOrganizerObjectImplCopyWithImpl(_$CreateOrganizerObjectImpl _value,
      $Res Function(_$CreateOrganizerObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? phoneNumber = null,
    Object? description = null,
    Object? image = null,
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? postalCode = null,
    Object? imagePath = null,
  }) {
    return _then(_$CreateOrganizerObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateOrganizerObjectImpl implements _CreateOrganizerObject {
  _$CreateOrganizerObjectImpl(
      this.name,
      this.type,
      this.phoneNumber,
      this.description,
      this.image,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      {this.imagePath = ""});

  @override
  final String name;
  @override
  final String type;
  @override
  final String phoneNumber;
  @override
  final String description;
  @override
  final File image;
  @override
  final String street;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  @JsonKey()
  final String imagePath;

  @override
  String toString() {
    return 'CreateOrganizerObject(name: $name, type: $type, phoneNumber: $phoneNumber, description: $description, image: $image, street: $street, city: $city, state: $state, postalCode: $postalCode, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrganizerObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type, phoneNumber,
      description, image, street, city, state, postalCode, imagePath);

  /// Create a copy of CreateOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrganizerObjectImplCopyWith<_$CreateOrganizerObjectImpl>
      get copyWith => __$$CreateOrganizerObjectImplCopyWithImpl<
          _$CreateOrganizerObjectImpl>(this, _$identity);
}

abstract class _CreateOrganizerObject implements CreateOrganizerObject {
  factory _CreateOrganizerObject(
      final String name,
      final String type,
      final String phoneNumber,
      final String description,
      final File image,
      final String street,
      final String city,
      final String state,
      final String postalCode,
      {final String imagePath}) = _$CreateOrganizerObjectImpl;

  @override
  String get name;
  @override
  String get type;
  @override
  String get phoneNumber;
  @override
  String get description;
  @override
  File get image;
  @override
  String get street;
  @override
  String get city;
  @override
  String get state;
  @override
  String get postalCode;
  @override
  String get imagePath;

  /// Create a copy of CreateOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOrganizerObjectImplCopyWith<_$CreateOrganizerObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateNewOrganizerObject {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  File get image => throw _privateConstructorUsedError;
  String get addressId => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;

  /// Create a copy of CreateNewOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateNewOrganizerObjectCopyWith<CreateNewOrganizerObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewOrganizerObjectCopyWith<$Res> {
  factory $CreateNewOrganizerObjectCopyWith(CreateNewOrganizerObject value,
          $Res Function(CreateNewOrganizerObject) then) =
      _$CreateNewOrganizerObjectCopyWithImpl<$Res, CreateNewOrganizerObject>;
  @useResult
  $Res call(
      {String name,
      String type,
      String phoneNumber,
      String description,
      File image,
      String addressId,
      String imagePath});
}

/// @nodoc
class _$CreateNewOrganizerObjectCopyWithImpl<$Res,
        $Val extends CreateNewOrganizerObject>
    implements $CreateNewOrganizerObjectCopyWith<$Res> {
  _$CreateNewOrganizerObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateNewOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? phoneNumber = null,
    Object? description = null,
    Object? image = null,
    Object? addressId = null,
    Object? imagePath = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      addressId: null == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateNewOrganizerObjectImplCopyWith<$Res>
    implements $CreateNewOrganizerObjectCopyWith<$Res> {
  factory _$$CreateNewOrganizerObjectImplCopyWith(
          _$CreateNewOrganizerObjectImpl value,
          $Res Function(_$CreateNewOrganizerObjectImpl) then) =
      __$$CreateNewOrganizerObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      String phoneNumber,
      String description,
      File image,
      String addressId,
      String imagePath});
}

/// @nodoc
class __$$CreateNewOrganizerObjectImplCopyWithImpl<$Res>
    extends _$CreateNewOrganizerObjectCopyWithImpl<$Res,
        _$CreateNewOrganizerObjectImpl>
    implements _$$CreateNewOrganizerObjectImplCopyWith<$Res> {
  __$$CreateNewOrganizerObjectImplCopyWithImpl(
      _$CreateNewOrganizerObjectImpl _value,
      $Res Function(_$CreateNewOrganizerObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateNewOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? phoneNumber = null,
    Object? description = null,
    Object? image = null,
    Object? addressId = null,
    Object? imagePath = null,
  }) {
    return _then(_$CreateNewOrganizerObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      null == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateNewOrganizerObjectImpl implements _CreateNewOrganizerObject {
  _$CreateNewOrganizerObjectImpl(this.name, this.type, this.phoneNumber,
      this.description, this.image, this.addressId,
      {this.imagePath = ""});

  @override
  final String name;
  @override
  final String type;
  @override
  final String phoneNumber;
  @override
  final String description;
  @override
  final File image;
  @override
  final String addressId;
  @override
  @JsonKey()
  final String imagePath;

  @override
  String toString() {
    return 'CreateNewOrganizerObject(name: $name, type: $type, phoneNumber: $phoneNumber, description: $description, image: $image, addressId: $addressId, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewOrganizerObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type, phoneNumber,
      description, image, addressId, imagePath);

  /// Create a copy of CreateNewOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateNewOrganizerObjectImplCopyWith<_$CreateNewOrganizerObjectImpl>
      get copyWith => __$$CreateNewOrganizerObjectImplCopyWithImpl<
          _$CreateNewOrganizerObjectImpl>(this, _$identity);
}

abstract class _CreateNewOrganizerObject implements CreateNewOrganizerObject {
  factory _CreateNewOrganizerObject(
      final String name,
      final String type,
      final String phoneNumber,
      final String description,
      final File image,
      final String addressId,
      {final String imagePath}) = _$CreateNewOrganizerObjectImpl;

  @override
  String get name;
  @override
  String get type;
  @override
  String get phoneNumber;
  @override
  String get description;
  @override
  File get image;
  @override
  String get addressId;
  @override
  String get imagePath;

  /// Create a copy of CreateNewOrganizerObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateNewOrganizerObjectImplCopyWith<_$CreateNewOrganizerObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateDriverObject {
  String get licenseInfo => throw _privateConstructorUsedError;
  DateTime? get licenseDate => throw _privateConstructorUsedError;
  File get image => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;

  /// Create a copy of CreateDriverObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDriverObjectCopyWith<CreateDriverObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDriverObjectCopyWith<$Res> {
  factory $CreateDriverObjectCopyWith(
          CreateDriverObject value, $Res Function(CreateDriverObject) then) =
      _$CreateDriverObjectCopyWithImpl<$Res, CreateDriverObject>;
  @useResult
  $Res call(
      {String licenseInfo,
      DateTime? licenseDate,
      File image,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String organizationId,
      String imagePath});
}

/// @nodoc
class _$CreateDriverObjectCopyWithImpl<$Res, $Val extends CreateDriverObject>
    implements $CreateDriverObjectCopyWith<$Res> {
  _$CreateDriverObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDriverObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseInfo = null,
    Object? licenseDate = freezed,
    Object? image = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? organizationId = null,
    Object? imagePath = null,
  }) {
    return _then(_value.copyWith(
      licenseInfo: null == licenseInfo
          ? _value.licenseInfo
          : licenseInfo // ignore: cast_nullable_to_non_nullable
              as String,
      licenseDate: freezed == licenseDate
          ? _value.licenseDate
          : licenseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateDriverObjectImplCopyWith<$Res>
    implements $CreateDriverObjectCopyWith<$Res> {
  factory _$$CreateDriverObjectImplCopyWith(_$CreateDriverObjectImpl value,
          $Res Function(_$CreateDriverObjectImpl) then) =
      __$$CreateDriverObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String licenseInfo,
      DateTime? licenseDate,
      File image,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String organizationId,
      String imagePath});
}

/// @nodoc
class __$$CreateDriverObjectImplCopyWithImpl<$Res>
    extends _$CreateDriverObjectCopyWithImpl<$Res, _$CreateDriverObjectImpl>
    implements _$$CreateDriverObjectImplCopyWith<$Res> {
  __$$CreateDriverObjectImplCopyWithImpl(_$CreateDriverObjectImpl _value,
      $Res Function(_$CreateDriverObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDriverObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseInfo = null,
    Object? licenseDate = freezed,
    Object? image = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? organizationId = null,
    Object? imagePath = null,
  }) {
    return _then(_$CreateDriverObjectImpl(
      null == licenseInfo
          ? _value.licenseInfo
          : licenseInfo // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == licenseDate
          ? _value.licenseDate
          : licenseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
      null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateDriverObjectImpl implements _CreateDriverObject {
  _$CreateDriverObjectImpl(
      this.licenseInfo,
      this.licenseDate,
      this.image,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.organizationId,
      {this.imagePath = ""});

  @override
  final String licenseInfo;
  @override
  final DateTime? licenseDate;
  @override
  final File image;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String password;
  @override
  final String organizationId;
  @override
  @JsonKey()
  final String imagePath;

  @override
  String toString() {
    return 'CreateDriverObject(licenseInfo: $licenseInfo, licenseDate: $licenseDate, image: $image, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password, organizationId: $organizationId, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDriverObjectImpl &&
            (identical(other.licenseInfo, licenseInfo) ||
                other.licenseInfo == licenseInfo) &&
            (identical(other.licenseDate, licenseDate) ||
                other.licenseDate == licenseDate) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      licenseInfo,
      licenseDate,
      image,
      firstName,
      lastName,
      email,
      phoneNumber,
      password,
      organizationId,
      imagePath);

  /// Create a copy of CreateDriverObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDriverObjectImplCopyWith<_$CreateDriverObjectImpl> get copyWith =>
      __$$CreateDriverObjectImplCopyWithImpl<_$CreateDriverObjectImpl>(
          this, _$identity);
}

abstract class _CreateDriverObject implements CreateDriverObject {
  factory _CreateDriverObject(
      final String licenseInfo,
      final DateTime? licenseDate,
      final File image,
      final String firstName,
      final String lastName,
      final String email,
      final String phoneNumber,
      final String password,
      final String organizationId,
      {final String imagePath}) = _$CreateDriverObjectImpl;

  @override
  String get licenseInfo;
  @override
  DateTime? get licenseDate;
  @override
  File get image;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get password;
  @override
  String get organizationId;
  @override
  String get imagePath;

  /// Create a copy of CreateDriverObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDriverObjectImplCopyWith<_$CreateDriverObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
