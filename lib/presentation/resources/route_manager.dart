import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/auth/account_type/view/account_type_view.dart';
import 'package:smart_transportation/presentation/auth/login/view/login_view.dart';
import 'package:smart_transportation/presentation/auth/register/view/register_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/dashboard_details/view/dashboard_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/driver/create_driver/view/create_driver_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/new_organization/view/new_organization_view.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/bloc/popup_cubit.dart';
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
  static const String adminRoute = "/organizationDetails";
  static const String createDriverRoute = "/createDriverRoute";

  static const String organizationDetails = "/organizationDetails";
  static const String switchAccount = "/switchAccount";
  static const String accountType = "/accountType";
  static const String dashboard = "/dashboard";
    static const String createNewOrganization = "/createNewOrganization";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        initLoginModule(); //di --login
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.accountType:
        return MaterialPageRoute(builder: (_) => AccountTypeView());
      case Routes.register:
        initRegisterModule(); //di -- register
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.homeViewOrganizer:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PopupCubit(),
            child: const HomeViewOrganizer(),
          ),
        );
      case Routes.organizationDetails:
        initCreateOrganization(); //di -- create org onBoarding
        return MaterialPageRoute(
            builder: (_) => const OrganizationDetailsView());
      case Routes.createDriverRoute:
        initCreateDriverModule(); //di -- register
        return MaterialPageRoute(builder: (_) => const CreateDriverView());
 case Routes.createNewOrganization:
        initCreateNewOrganization(); //di -- register
        return MaterialPageRoute(builder: (_) => const NewOrganizationView());
      case Routes.dashboard:
        initGetAllOrganizationsModule();
        return MaterialPageRoute(builder: (_) => const DashboardView());
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
