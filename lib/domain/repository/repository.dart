import 'package:smart_transportation/data/network/requests.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_transportation/domain/model/models.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationSignIn>> login(LoginRequest loginRequest);
}