import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class UserFavoritiesRepository {
  Future<Either<Failure, void>> addToStorage(String movieId);

  Future<Either<Failure, void>> removeFromStorage(String movieId);
}
