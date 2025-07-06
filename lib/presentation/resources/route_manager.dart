import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/auth/account_type/view/account_type_view.dart';
import 'package:smart_transportation/presentation/auth/login/view/login_view.dart';
import 'package:smart_transportation/presentation/auth/register/view/register_view.dart';
import 'package:smart_transportation/presentation/dashboard/main_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/bus/bus_list_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/driver/view/diver_list_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/member/view/member_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/reports/reports_list_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/settings/OrganizationDetailsScreen.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/settings/settings_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/students/view/students_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/driver/create_driver/view/create_driver_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/new_organization/view/new_organization_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/supervisor/view/supervisor_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/trip_history/trip_history_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/view/other_view.dart';
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
  static const String memberRoute = "/memberRoute";
  static const String studentRoute = "/studentRoute";
  static const String otherRoute = "/otherRoute";

  static const String sendNotificationsRoute = "/send_notifications"; // New
  static const String driversRoute = "/drivers"; // New
  static const String supervisorsRoute = "/supervisors"; // New
  static const String busesRoute = "/buses"; // New
  static const String blockedZoneRoute = "/blocked_zone"; // New
  static const String maintenanceRoute = "/maintenance"; // New
  static const String liveTripsRoute = "/live_trips"; // New
  static const String tripsScheduleRoute = "/trips_schedule"; // New
  static const String tripsHistoryRoute = "/trips_history"; // New
  static const String reportsRoute = "/reports"; // New
  static const String rolesRoute = "/roles"; // New
  static const String permissionsRoute = "/permissions"; // New
  static const String settingsRoute = "/settings"; // New
  static const String tripHistory = "/tripHistory"; // New
  static const String organization = "/organization"; // N
  static const String address = "/address"; // N

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
        return MaterialPageRoute(builder: (_) => const MainView());
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
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.memberRoute:
        return MaterialPageRoute(builder: (_) => const MemberView());
      case Routes.studentRoute:
        return MaterialPageRoute(builder: (_) => const StudentsView());
      case Routes.otherRoute:
        return MaterialPageRoute(builder: (_) => const OtherRouteView());
      case Routes.driversRoute:
        return MaterialPageRoute(builder: (_) => const DriverListView());
      case Routes.supervisorsRoute:
        return MaterialPageRoute(builder: (_) => const SupervisorListView());
      case Routes.tripHistory:
        return MaterialPageRoute(builder: (_) => const TripHistoryView());
      case Routes.busesRoute:
        return MaterialPageRoute(builder: (_) => const BusListView());
      case Routes.reportsRoute:
        return MaterialPageRoute(builder: (_) => const ReportsListView());

      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) =>  const SettingsScreen());
      case Routes.organization:
        return MaterialPageRoute(builder: (_) =>   OrganizationDetailsScreen());
      case Routes.address:
        return MaterialPageRoute(builder: (_) =>   AddressDetailsScreen());
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
