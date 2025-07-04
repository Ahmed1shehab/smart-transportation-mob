import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LocalizationService with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  Map<String, String> _translations = {};

  Locale get currentLocale => _currentLocale;

  Future<void> load(Locale locale) async {
    _currentLocale = locale;
    final jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _translations = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    notifyListeners();
  }

  String translate(String key) => _translations[key] ?? key;

  void changeLanguage(String languageCode) async {
    await load(Locale(languageCode));
  }
}
