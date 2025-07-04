import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'startTime') required DateTime departureTime,
    required Bus bus,
    required Driver driver,
    required Supervisor supervisor,
    required int totalStudents,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) =>
      _$TripFromJson(json);
}

@freezed
class Bus with _$Bus {
  const factory Bus({
    required String model,
  }) = _Bus;

  factory Bus.fromJson(Map<String, dynamic> json) =>
      _$BusFromJson(json);
}

@freezed
class Driver with _$Driver {
  const factory Driver({
    required String firstName,
    required String lastName,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) =>
      _$DriverFromJson(json);
}

@freezed
class Supervisor with _$Supervisor {
  const factory Supervisor({
    required String firstName,
    required String lastName,
  }) = _Supervisor;

  factory Supervisor.fromJson(Map<String, dynamic> json) =>
      _$SupervisorFromJson(json);
}
