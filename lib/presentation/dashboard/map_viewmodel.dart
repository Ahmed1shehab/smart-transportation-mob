import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/model/students_model.dart' as model;
import '../../../app/constants.dart';

class MapViewModel extends ChangeNotifier {
  List<model.Student> _students = [];
  List<model.Student> get students => _students;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  Future<void> fetchTripStudents(String tripId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await Dio().get(
        "${Constants.baseUrl}/supervisor/trip/tripStudents/$tripId",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );
      print('API Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final List studentsJson = response.data['data'];
        _students = studentsJson.map((json) => model.Student.safeFromJson(json)).toList();
        errorMessage = null;
      } else {
        errorMessage = 'Failed to load students';
        _students = [];
      }
    } catch (e) {
      errorMessage = 'Failed to fetch student data: $e';
      _students = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
