import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/register.dart';
import '../entities/auth_params.dart';
import '../repositories/auth_repository.dart';

class PostRegister extends UseCase<Register, AuthParams> {
  final AuthRepository authRepository;

  PostRegister(this.authRepository);

  @override
  Future<Either<Failure, Register>> call(AuthParams params) =>
      authRepository.register(params);
}
