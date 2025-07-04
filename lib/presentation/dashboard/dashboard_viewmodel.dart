import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/model/trip_model.dart';
import '../../../app/constants.dart';

class DashboardViewModel extends ChangeNotifier {
  Trip? _trip;
  String? tripId;
  String? busModel;
  String? driverName;
  String? supervisorName;
  int totalStudents = 0;

  Trip? get trip => _trip;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchNextTrip() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await Dio().get(
          "${Constants.baseUrl}/supervisor/trip/nextTrip",
          options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      final responseData = response.data['data'];
      _trip = Trip.fromJson(responseData);
      tripId = _trip?.id;
      busModel = _trip?.bus.model;
      driverName = "${_trip?.driver.firstName} ${_trip?.driver.lastName}";
      supervisorName = "${_trip?.supervisor.firstName} ${_trip?.supervisor.lastName}";
      totalStudents = _trip?.totalStudents ?? 0;



      if (response.statusCode == 200 && response.data != null) {

        _trip = Trip.fromJson(response.data['data']);

      }
    } catch (e) {
      _trip = null;
      print("Failed to fetch trip: $e");

    }


    _isLoading = false;
    notifyListeners();
  }
}