// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripImpl _$$TripImplFromJson(Map<String, dynamic> json) => _$TripImpl(
      id: json['_id'] as String,
      departureTime: DateTime.parse(json['startTime'] as String),
      bus: Bus.fromJson(json['bus'] as Map<String, dynamic>),
      driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
      supervisor:
          Supervisor.fromJson(json['supervisor'] as Map<String, dynamic>),
      totalStudents: (json['totalStudents'] as num).toInt(),
    );

Map<String, dynamic> _$$TripImplToJson(_$TripImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'startTime': instance.departureTime.toIso8601String(),
      'bus': instance.bus,
      'driver': instance.driver,
      'supervisor': instance.supervisor,
      'totalStudents': instance.totalStudents,
    };

_$BusImpl _$$BusImplFromJson(Map<String, dynamic> json) => _$BusImpl(
      model: json['model'] as String,
    );

Map<String, dynamic> _$$BusImplToJson(_$BusImpl instance) => <String, dynamic>{
      'model': instance.model,
    };

_$DriverImpl _$$DriverImplFromJson(Map<String, dynamic> json) => _$DriverImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$$DriverImplToJson(_$DriverImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

_$SupervisorImpl _$$SupervisorImplFromJson(Map<String, dynamic> json) =>
    _$SupervisorImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$$SupervisorImplToJson(_$SupervisorImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
