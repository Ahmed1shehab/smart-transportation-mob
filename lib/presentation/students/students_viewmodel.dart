import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/model/students_model.dart';
import '../../app/constants.dart';

class StudentsViewModel extends ChangeNotifier {
  List<Student> _students = [];
  bool _isLoading = false;
  String? _error;

  List<Student> get students => _students;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get scannedCount => _students.where((s) => s.disabilities.isNotEmpty).length;
  int get totalCount => _students.length;

  Future<void> fetchStudents(String tripId) async {
    _isLoading = true;
    _error = null;
    _students = [];
    notifyListeners();

    if (tripId.isEmpty) {
      _isLoading = false;
      // No error, just no students
      notifyListeners();
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await Dio().get(
        "${Constants.baseUrl}/supervisor/trip/tripStudents/$tripId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'];
        _students = data.map((json) => Student.safeFromJson(json)).toList();
      } else {
        _students = [];
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


}
