import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/profile/domain/entities/profile_details_params.dart';
import 'package:moviedb/features/profile/domain/repositories/profile_repository.dart';

class DoEditUserProfile extends UseCase<void, ProfileDetailsParams> {
  final ProfileRepository profileRepository;

  DoEditUserProfile(this.profileRepository);

  @override
  Future<Either<Failure, User>> call(params) =>
      profileRepository.editUserProfile(params);
}
