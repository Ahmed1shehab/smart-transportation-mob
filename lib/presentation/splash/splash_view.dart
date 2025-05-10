import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/app/di.dart';

import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.login);
    // _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
    //   if (isUserLoggedIn) {
    //     //navigate Main Screen
    //     Navigator.pushReplacementNamed(context, Routes.mainRoute);
    //   } else {
    //     _appPreferences
    //         .isOnBoardingScreenViewed()
    //         .then((isOnBoardingScreenViewed) {
    //       if (isOnBoardingScreenViewed) {
    //         //navigate login
    //         Navigator.pushReplacementNamed(context, Routes.login);
    //       } else {
    //         //navigate onboarding
    //         Navigator.pushReplacementNamed(context, Routes.onBoarding);
    //       }
    //     });
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
