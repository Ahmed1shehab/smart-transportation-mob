import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';

class GetOrganizationUsecase extends BaseUseCase<String, OrganizationItem> {
  final Repository _repository;

  GetOrganizationUsecase(this._repository);

  @override
  Future<Either<Failure, OrganizationItem>> execute(String input) async {
    return await _repository.getOrganization(input);
  }
}
