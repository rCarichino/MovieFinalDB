import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviedb/features/profile/domain/entities/profile_details_params.dart';

import '../../../../core/error/failure.dart';
import '../entities/reset_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> resetParams(ResetParams resetParams);

  Future<Either<Failure, void>> deleteUser(ResetParams resetParams);

  Future<Either<Failure, User>> editUserProfile(
      ProfileDetailsParams profileDetailsParams);
}
