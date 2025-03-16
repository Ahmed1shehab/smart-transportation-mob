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
import 'package:smart_transportation/domain/usecase/signin_usecase.dart';
import 'package:smart_transportation/presentation/auth/login/viewmodel/login_viewmodel.dart';

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
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSource(instance<AppServiceClient>())); // Ensure this line is correct

  // Repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<SigninUsecase>()) {
    instance.registerFactory<SigninUsecase>(() => SigninUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
