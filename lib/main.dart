import 'package:flutter/material.dart';
import 'package:smart_transportation/app/app.dart';
import 'package:smart_transportation/app/di.dart';



import 'package:flutter/material.dart';
import 'package:smart_transportation/home_screen.dart';
import 'package:smart_transportation/storage_services.dart';
import 'sign_in_screen.dart';

//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final token = await StorageService.getToken();
//   runApp(MyApp(initialRoute: token != null ? '/home' : '/signin'));
// }
//
// class MyApp extends StatelessWidget {
//   final String initialRoute;
//
//   MyApp({required this.initialRoute});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: initialRoute,
//       routes: {
//         '/signin': (context) => SignInScreen(),
//         '/home': (context) => HomeScreen(), // Create this screen
//       },
//     );
//   }
// }
//

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await initAppModule();

  // Run the app
  runApp(MyApp());
}