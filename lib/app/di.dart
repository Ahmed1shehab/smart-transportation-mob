import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor_app/data/repository/repository_impl.dart';
import 'package:supervisor_app/domain/repository/repository.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';

import '../domain/usecase/signin_usecase.dart';
import '../presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'app_prefs.dart';
import 'constants.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Shared Prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network info instance
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker.createInstance()));

  // Dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // Dio instance
  Dio dio = await instance<DioFactory>().getDio();

  // App Service Client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio, baseUrl: Constants.baseUrl));


  // Remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSource(instance<AppServiceClient>())); // Ensure this line is correct

  // Repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<SigninUsecase>()) {
    instance.registerFactory<SigninUsecase>(() => SigninUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
