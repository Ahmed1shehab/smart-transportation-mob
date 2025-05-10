import 'package:flutter/foundation.dart';

bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

class UrlUtils {
  static String fixImageUrl(String url) {
    if (url.isEmpty) return url;

    // Replace backslashes with forward slashes
    String fixed = url.replaceAll(r'\', '/');

    // Replace localhost with 10.0.2.2 for Android emulator
    if (fixed.contains('localhost') && !kIsWeb) {
      fixed = fixed.replaceFirst('localhost', '10.0.2.2');
    }

    return fixed;
  }
}