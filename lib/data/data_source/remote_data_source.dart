import 'package:smart_transportation/data/network/app_api.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/data/response/response.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationSignInResponse> login(LoginRequest request) async {
    return await _appServiceClient.login(
      request.identifier,
      request.password,
    );
  }

  @override
  Future<CreateOrganizerResponse> createOrganizer(
      CreateOrganizerRequest request) async {
    final formData = await request.toFormData();
    return await _appServiceClient.createNewOrganizer(formData);
  }
  
  @override
  Future<CreateOrganizerResponse> createNewOrganizer(CreateNewOrganizationRequest request)async {
    final formData = await request.toFormData();
    return await _appServiceClient.createNewOrganization(formData);
  }
  @override
  Future<AuthenticationSignUpResponse> register(
      RegisterRequest registerRequest) async {
    final formData = await registerRequest.toFormData();
    return await _appServiceClient.register(formData);
  }

  @override
  Future<GetAllOrganizationsResponse> getAllOrganizationsData() async {
    return await _appServiceClient.getAllOrganizationsData();
  }

  @override
  Future<GetOneOrganizationResponse> getOrganizationData(String id) async {
    return await _appServiceClient.getOrganizationData(id);
  }

  @override
  Future<CreateDriverResponse> createDriver(CreateDriverRequest request) async {
    final formData = await request.toFormData();
    return await _appServiceClient.createNewDriver(formData);
  }
  
}

abstract class RemoteDataSource {
  Future<AuthenticationSignInResponse> login(LoginRequest loginRequest);

  Future<AuthenticationSignUpResponse> register(
      RegisterRequest registerRequest);

  Future<CreateOrganizerResponse> createOrganizer(
      CreateOrganizerRequest request);
       Future<CreateOrganizerResponse> createNewOrganizer(
      CreateNewOrganizationRequest request);

  Future<GetAllOrganizationsResponse> getAllOrganizationsData();

  Future<GetOneOrganizationResponse> getOrganizationData(String id);

  Future<CreateDriverResponse> createDriver(CreateDriverRequest request);
}
