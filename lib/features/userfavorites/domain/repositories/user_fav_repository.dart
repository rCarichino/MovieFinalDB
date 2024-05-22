import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_fav_ent.dart';

abstract class UserFavoritiesRepository {
  Future<Either<Failure, void>> addToStorage(UserFavEnt userFavEnt);
  Future<Either<Failure, void>> removeFromStorage(UserFavEnt userFavEnt);
  Future<Either<Failure, List<UserFavEnt>>> getFromStorage(UserFavEnt userFavEnt);
}
