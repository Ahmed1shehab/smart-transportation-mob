import 'package:flutter/material.dart';
import 'package:smart_transportation/app/app.dart';
import 'package:smart_transportation/app/di.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await initAppModule();

  // Run the app
  runApp(MyApp());
}