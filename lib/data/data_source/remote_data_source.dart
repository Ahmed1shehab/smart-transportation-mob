import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/network/app_api.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/data/response/response.dart';

class RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSource(this._appServiceClient);

  Future<AuthenticationSignInResponse> login(LoginRequest request) async {
    return await _appServiceClient.login(
      request.identifier,
      request.password,
    );
  }

  Future<CreateOrganizerResponse> createOrganizer(
      CreateOrganizerRequest request) async {
    return await _appServiceClient.createNewOrganizer(
      request.name,
      request.type,
      request.phoneNumber,
      request.description,
      request.image,
      request.street,
      request.city,
      request.state,
      request.postalCode,
    );
  }}