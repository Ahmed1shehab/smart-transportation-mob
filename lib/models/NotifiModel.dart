import 'package:flutter/cupertino.dart';

class NotificationModel {
  final String type; // "bus" or "warning"
  final String title;
  final String details;
  final DateTime date;
  final IconData icon;
  final Color iconColor;

  NotificationModel({
    required this.type,
    required this.title,
    required this.details,
    required this.date,
    required this.icon,
    required this.iconColor,
  });
}
