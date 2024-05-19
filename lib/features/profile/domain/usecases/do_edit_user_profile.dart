import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/profile/domain/entities/reset_params.dart';
import 'package:moviedb/features/profile/domain/repositories/profile_repository.dart';

class DoEditUserProfile extends UseCase<void, ResetParams> {
  final ProfileRepository profileRepository;

  DoEditUserProfile(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(params) => profileRepository.editUserProfile(params);
}
