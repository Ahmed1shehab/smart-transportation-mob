import '../network/app_api.dart';
import '../network/requests.dart';
import '../response/response.dart';

class RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSource(this.appServiceClient);

  Future<AuthenticationSignInResponse> login(LoginRequest request) async {
    return await appServiceClient.login(request); // ✅ Use Retrofit
  }
}
