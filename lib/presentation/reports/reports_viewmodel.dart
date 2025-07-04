import 'package:flutter/material.dart';

class Report {
  final String id;
  final String title;
  final String status;

  Report({required this.id, required this.title, required this.status});
}

class ReportsViewModel extends ChangeNotifier {
  Report? currentReport;
  List<Report> previousReports = [];

  ReportsViewModel() {
    // Dummy data
    currentReport = Report(
      id: '001',
      title: 'DailyReport',
      status: 'In Progress',
    );

    previousReports = [
      Report(id: '002', title: 'Weekly Summary', status: 'Completed'),
      Report(id: '099', title: 'Incident Report', status: 'Completed'),
    ];
  }
}
