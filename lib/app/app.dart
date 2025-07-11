import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/theme_manager.dart';
class MyApp extends StatefulWidget {
  int appState = 0;

  //named constructor
  MyApp._internal();

  static final MyApp _instance = MyApp._internal(); //singleton

  factory MyApp() => _instance; //factory

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}

