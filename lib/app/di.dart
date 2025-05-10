import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/data/data_source/remote_data_source.dart';
import 'package:smart_transportation/data/network/app_api.dart';
import 'package:smart_transportation/data/network/dio_factory.dart';
import 'package:smart_transportation/data/network/network_info.dart';
import 'package:smart_transportation/data/repository/repository_impl.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/create_driver_usecase.dart';
import 'package:smart_transportation/domain/usecase/create_new_organization.dart';
import 'package:smart_transportation/domain/usecase/create_organizer_usecase.dart';
import 'package:smart_transportation/domain/usecase/get_all_organizations_usecase.dart';
import 'package:smart_transportation/domain/usecase/get_organization_usecase.dart';
import 'package:smart_transportation/domain/usecase/signin_usecase.dart';
import 'package:smart_transportation/domain/usecase/signup_usecase.dart';
import 'package:smart_transportation/presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'package:smart_transportation/presentation/auth/register/viewmodel/register_viewmodel.dart';
import 'package:smart_transportation/presentation/dashboard/pages/dashboard_details/viewmodel/dashboard_viewmodel.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/driver/create_driver/viewmodel/create_driver_viewmodel.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/new_organization/viewmodel/new_organization_viewmodel.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/viewmodel/organization_details_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Shared Prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.createInstance()));

  // Dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // Dio instance
  Dio dio = await instance<DioFactory>().getDio();

  // App Service Client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance())); // Ensure this line is correct

  // Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<SigninUsecase>()) {
    instance.registerFactory<SigninUsecase>(() => SigninUsecase(instance()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance(), instance()));
  }
}

initCreateOrganization() {
  if (!GetIt.I.isRegistered<CreateOrganizerUsecase>()) {
    instance.registerFactory<CreateOrganizerUsecase>(
        () => CreateOrganizerUsecase(instance()));
    instance.registerFactory<OrganizationDetailsViewmodel>(
        () => OrganizationDetailsViewmodel(instance()));
  }
}
initCreateNewOrganization() {
  if (!GetIt.I.isRegistered<CreateNewOrganizerUsecase>()) {
    instance.registerFactory<CreateNewOrganizerUsecase>(
        () => CreateNewOrganizerUsecase(instance()));
    instance.registerFactory<NewOrganizationViewmodel>(
        () => NewOrganizationViewmodel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<SignupUsecase>()) {
    instance.registerFactory<SignupUsecase>(() => SignupUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

initGetAllOrganizationsModule() {
  if (!GetIt.I.isRegistered<GetAllOrganizationsUsecase>()) {
    instance.registerFactory<GetAllOrganizationsUsecase>(
            () => GetAllOrganizationsUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<GetOrganizationUsecase>()) {
    instance.registerFactory<GetOrganizationUsecase>(
            () => GetOrganizationUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<DashboardViewModel>()) {
    instance.registerFactory<DashboardViewModel>(
            () => DashboardViewModel(instance(), instance()));
  }
}

initCreateDriverModule() {
  if (!GetIt.I.isRegistered<CreateDriverUsecase>()) {
    instance.registerFactory<CreateDriverUsecase>(() => CreateDriverUsecase(instance()));
    instance.registerFactory<CreateDiverViewModel>(
            () => CreateDiverViewModel(instance(), instance()));
  }
}