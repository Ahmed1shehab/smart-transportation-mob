import 'package:smart_transportation/data/network/requests.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_transportation/domain/model/models.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationSignIn>> login(LoginRequest loginRequest);
  Future<Either<Failure, AuthenticationSignUp>> register(RegisterRequest registerRequest);
  Future<Either<Failure, Organizer>> createOrganization(CreateOrganizerRequest createOrganizationRequest);
  Future<Either<Failure, Organizer>> createNewOrganization(CreateNewOrganizationRequest createNewOrganizationRequest);

  Future<Either<Failure, OrganizationItem>> getOrganization(String id);
  Future<Either<Failure, List<OrganizationItem>>> getAllOrganizations();
  Future<Either<Failure, Driver>> createDriver(CreateDriverRequest createDriverRequest);


}