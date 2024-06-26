import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_params.dart';
import '../repositories/auth_repository.dart';

class CreateUser extends UseCase<UserCredential, AuthParams> {
  final AuthRepository authRepository;

  CreateUser(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(AuthParams params) =>
      authRepository.register(params);
}
