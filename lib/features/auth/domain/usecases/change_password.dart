import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ChangePassword extends UseCase<void, String> {
  final AuthRepository authRepository;

  ChangePassword(this.authRepository);

  @override
  Future<Either<Failure, void>> call(String email) =>
      authRepository.changePassword(email);
}
