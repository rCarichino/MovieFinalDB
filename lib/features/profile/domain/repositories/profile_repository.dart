import 'package:dartz/dartz.dart';
import 'package:moviedb/features/auth/domain/entities/auth_params.dart';

import '../../../../core/error/failure.dart';
import '../entities/reset_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> resetParams(ResetParams resetParams);
  Future<Either<Failure, void>> deleteUser(ResetParams resetParams);
  Future<Either<Failure, void>> editUserProfile(ResetParams resetParams);
}