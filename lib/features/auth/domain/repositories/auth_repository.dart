import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_params.dart';

abstract class AuthRepository{

  Future<Either<Failure,UserCredential>> register(AuthParams authParams);
  Future<Either<Failure, User>> login(AuthParams authParams);

}