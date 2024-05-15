import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../entities/auth_params.dart';

abstract class AuthRepository{

  Future<Either<Failure, Register>> register(AuthParams authParams);
  Future<Either<Failure, Login>> login(AuthParams authParams);

}