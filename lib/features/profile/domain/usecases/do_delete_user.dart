import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/profile/domain/repositories/profile_repository.dart';

import '../entities/reset_params.dart';

class DoDeleteUser extends UseCase<void, ResetParams> {
  final ProfileRepository profileRepository;

  DoDeleteUser(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(params) =>
      profileRepository.deleteUser(params);
}
