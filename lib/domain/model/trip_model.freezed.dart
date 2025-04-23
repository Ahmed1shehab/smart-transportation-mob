// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  @JsonKey(name: 'startTime')
  DateTime get departureTime => throw _privateConstructorUsedError;
  Bus get bus => throw _privateConstructorUsedError;
  Driver get driver => throw _privateConstructorUsedError;
  Supervisor get supervisor => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call(
      {@JsonKey(name: 'startTime') DateTime departureTime,
      Bus bus,
      Driver driver,
      Supervisor supervisor,
      int totalStudents});

  $BusCopyWith<$Res> get bus;
  $DriverCopyWith<$Res> get driver;
  $SupervisorCopyWith<$Res> get supervisor;
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departureTime = null,
    Object? bus = null,
    Object? driver = null,
    Object? supervisor = null,
    Object? totalStudents = null,
  }) {
    return _then(_value.copyWith(
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bus: null == bus
          ? _value.bus
          : bus // ignore: cast_nullable_to_non_nullable
              as Bus,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      supervisor: null == supervisor
          ? _value.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as Supervisor,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BusCopyWith<$Res> get bus {
    return $BusCopyWith<$Res>(_value.bus, (value) {
      return _then(_value.copyWith(bus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res> get driver {
    return $DriverCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SupervisorCopyWith<$Res> get supervisor {
    return $SupervisorCopyWith<$Res>(_value.supervisor, (value) {
      return _then(_value.copyWith(supervisor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
          _$TripImpl value, $Res Function(_$TripImpl) then) =
      __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startTime') DateTime departureTime,
      Bus bus,
      Driver driver,
      Supervisor supervisor,
      int totalStudents});

  @override
  $BusCopyWith<$Res> get bus;
  @override
  $DriverCopyWith<$Res> get driver;
  @override
  $SupervisorCopyWith<$Res> get supervisor;
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departureTime = null,
    Object? bus = null,
    Object? driver = null,
    Object? supervisor = null,
    Object? totalStudents = null,
  }) {
    return _then(_$TripImpl(
      departureTime: null == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bus: null == bus
          ? _value.bus
          : bus // ignore: cast_nullable_to_non_nullable
              as Bus,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      supervisor: null == supervisor
          ? _value.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as Supervisor,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl(
      {@JsonKey(name: 'startTime') required this.departureTime,
      required this.bus,
      required this.driver,
      required this.supervisor,
      required this.totalStudents});

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  @JsonKey(name: 'startTime')
  final DateTime departureTime;
  @override
  final Bus bus;
  @override
  final Driver driver;
  @override
  final Supervisor supervisor;
  @override
  final int totalStudents;

  @override
  String toString() {
    return 'Trip(departureTime: $departureTime, bus: $bus, driver: $driver, supervisor: $supervisor, totalStudents: $totalStudents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.bus, bus) || other.bus == bus) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.supervisor, supervisor) ||
                other.supervisor == supervisor) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, departureTime, bus, driver, supervisor, totalStudents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(
      this,
    );
  }
}

abstract class _Trip implements Trip {
  const factory _Trip(
      {@JsonKey(name: 'startTime') required final DateTime departureTime,
      required final Bus bus,
      required final Driver driver,
      required final Supervisor supervisor,
      required final int totalStudents}) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  @JsonKey(name: 'startTime')
  DateTime get departureTime;
  @override
  Bus get bus;
  @override
  Driver get driver;
  @override
  Supervisor get supervisor;
  @override
  int get totalStudents;
  @override
  @JsonKey(ignore: true)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bus _$BusFromJson(Map<String, dynamic> json) {
  return _Bus.fromJson(json);
}

/// @nodoc
mixin _$Bus {
  String get model => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusCopyWith<Bus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusCopyWith<$Res> {
  factory $BusCopyWith(Bus value, $Res Function(Bus) then) =
      _$BusCopyWithImpl<$Res, Bus>;
  @useResult
  $Res call({String model});
}

/// @nodoc
class _$BusCopyWithImpl<$Res, $Val extends Bus> implements $BusCopyWith<$Res> {
  _$BusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusImplCopyWith<$Res> implements $BusCopyWith<$Res> {
  factory _$$BusImplCopyWith(_$BusImpl value, $Res Function(_$BusImpl) then) =
      __$$BusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String model});
}

/// @nodoc
class __$$BusImplCopyWithImpl<$Res> extends _$BusCopyWithImpl<$Res, _$BusImpl>
    implements _$$BusImplCopyWith<$Res> {
  __$$BusImplCopyWithImpl(_$BusImpl _value, $Res Function(_$BusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$BusImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusImpl implements _Bus {
  const _$BusImpl({required this.model});

  factory _$BusImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusImplFromJson(json);

  @override
  final String model;

  @override
  String toString() {
    return 'Bus(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusImplCopyWith<_$BusImpl> get copyWith =>
      __$$BusImplCopyWithImpl<_$BusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusImplToJson(
      this,
    );
  }
}

abstract class _Bus implements Bus {
  const factory _Bus({required final String model}) = _$BusImpl;

  factory _Bus.fromJson(Map<String, dynamic> json) = _$BusImpl.fromJson;

  @override
  String get model;
  @override
  @JsonKey(ignore: true)
  _$$BusImplCopyWith<_$BusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return _Driver.fromJson(json);
}

/// @nodoc
mixin _$Driver {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverCopyWith<Driver> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverCopyWith<$Res> {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) then) =
      _$DriverCopyWithImpl<$Res, Driver>;
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class _$DriverCopyWithImpl<$Res, $Val extends Driver>
    implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverImplCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$$DriverImplCopyWith(
          _$DriverImpl value, $Res Function(_$DriverImpl) then) =
      __$$DriverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class __$$DriverImplCopyWithImpl<$Res>
    extends _$DriverCopyWithImpl<$Res, _$DriverImpl>
    implements _$$DriverImplCopyWith<$Res> {
  __$$DriverImplCopyWithImpl(
      _$DriverImpl _value, $Res Function(_$DriverImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$DriverImpl(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverImpl implements _Driver {
  const _$DriverImpl({required this.firstName, required this.lastName});

  factory _$DriverImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'Driver(firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      __$$DriverImplCopyWithImpl<_$DriverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverImplToJson(
      this,
    );
  }
}

abstract class _Driver implements Driver {
  const factory _Driver(
      {required final String firstName,
      required final String lastName}) = _$DriverImpl;

  factory _Driver.fromJson(Map<String, dynamic> json) = _$DriverImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  @JsonKey(ignore: true)
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Supervisor _$SupervisorFromJson(Map<String, dynamic> json) {
  return _Supervisor.fromJson(json);
}

/// @nodoc
mixin _$Supervisor {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupervisorCopyWith<Supervisor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupervisorCopyWith<$Res> {
  factory $SupervisorCopyWith(
          Supervisor value, $Res Function(Supervisor) then) =
      _$SupervisorCopyWithImpl<$Res, Supervisor>;
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class _$SupervisorCopyWithImpl<$Res, $Val extends Supervisor>
    implements $SupervisorCopyWith<$Res> {
  _$SupervisorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupervisorImplCopyWith<$Res>
    implements $SupervisorCopyWith<$Res> {
  factory _$$SupervisorImplCopyWith(
          _$SupervisorImpl value, $Res Function(_$SupervisorImpl) then) =
      __$$SupervisorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class __$$SupervisorImplCopyWithImpl<$Res>
    extends _$SupervisorCopyWithImpl<$Res, _$SupervisorImpl>
    implements _$$SupervisorImplCopyWith<$Res> {
  __$$SupervisorImplCopyWithImpl(
      _$SupervisorImpl _value, $Res Function(_$SupervisorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$SupervisorImpl(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupervisorImpl implements _Supervisor {
  const _$SupervisorImpl({required this.firstName, required this.lastName});

  factory _$SupervisorImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupervisorImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'Supervisor(firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupervisorImplCopyWith<_$SupervisorImpl> get copyWith =>
      __$$SupervisorImplCopyWithImpl<_$SupervisorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupervisorImplToJson(
      this,
    );
  }
}

abstract class _Supervisor implements Supervisor {
  const factory _Supervisor(
      {required final String firstName,
      required final String lastName}) = _$SupervisorImpl;

  factory _Supervisor.fromJson(Map<String, dynamic> json) =
      _$SupervisorImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  @JsonKey(ignore: true)
  _$$SupervisorImplCopyWith<_$SupervisorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
