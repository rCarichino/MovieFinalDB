import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';

import '../entities/reset_params.dart';
import '../repositories/profile_repository.dart';

class DoResetParams extends UseCase<void, ResetParams> {
  final ProfileRepository profileRepository;

  DoResetParams(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(ResetParams params) =>
      profileRepository.resetParams(params);
}
