import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/auth/login.dart';
import 'Screens/onboarding.dart';


bool show=true;
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark
  ));
  final prefs=await SharedPreferences.getInstance();
  show= prefs.getBool('on boarding') ?? true;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:show ?   const Introscreen():const LoginScreen(),);
  }
}
