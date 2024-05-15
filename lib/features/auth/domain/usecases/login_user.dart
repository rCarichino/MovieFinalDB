import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_params.dart';
import '../repositories/auth_repository.dart';

class LoginUser extends UseCase<User, AuthParams> {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(AuthParams params) =>
      authRepository.login(params);
}
