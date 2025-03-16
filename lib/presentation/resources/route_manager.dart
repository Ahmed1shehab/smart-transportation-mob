import 'package:flutter/material.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/auth/login/view/login_view.dart';
import 'package:smart_transportation/presentation/auth/register/register_view.dart';
import 'package:smart_transportation/presentation/dashboard/dashboard_view.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/home_view_organizer.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/pages/organization_details_view.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/splash/splash_view.dart';
import '../on_boarding/view/on_boarding_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String mainRoute = "/main";
  static const String homeViewOrganizer = "/HomeViewOrganizer";

  static const String organizationDetails = "/organizationDetails";
  static const String switchAccount = "/switchAccount";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        initLoginModule(); //di
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.homeViewOrganizer:
        return MaterialPageRoute(builder: (_) => const HomeViewOrganizer());
      case Routes.organizationDetails:
        return MaterialPageRoute(
            builder: (_) => const OrganizationDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
