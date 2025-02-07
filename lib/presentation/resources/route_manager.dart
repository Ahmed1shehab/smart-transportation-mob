import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/splash/splash_view.dart';

import '../login/login_view.dart';
import '../on_boarding/view/on_boarding_view.dart';

class Routes{
  static const String splashRoute ='/';
  static const String onBoarding ='/onBoarding';
  static const String login ='/login';

}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return unDefinedRoute();
  }
}

static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title:  const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }
}
