import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/route_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? _timer;
  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoarding);
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
