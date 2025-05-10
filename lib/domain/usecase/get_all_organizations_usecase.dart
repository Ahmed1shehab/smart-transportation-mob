import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';

class GetAllOrganizationsUsecase
    extends BaseUseCase<void, List<OrganizationItem>> {
  final Repository _repository;

  GetAllOrganizationsUsecase(this._repository);

  @override
  Future<Either<Failure, List<OrganizationItem>>> execute(void input) async {
    return await _repository.getAllOrganizations();
  }
}
