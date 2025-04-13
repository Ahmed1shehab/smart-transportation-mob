import 'package:flutter/material.dart';
import 'package:supervisor_app/presentation/resources/strings_manager.dart';
import '../../app/di.dart';
import '../auth/login/view/login_view.dart';
import '../auth/register/register_view.dart';
import '../dashboard/dashboard_view.dart';
import '../on_boarding/view/on_boarding_view.dart';
import '../splash/splash_view.dart';

class Routes{
  static const String splashRoute ='/';
  static const String onBoarding ='/onBoarding';
  static const String login ='/login';
  static const String register ='/register';
  static const String mainRoute = "/main";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());

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
