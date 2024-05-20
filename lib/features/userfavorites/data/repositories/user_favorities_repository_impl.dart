import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/userfavorites/domain/repositories/user_favorities_repository.dart';

class UserFavoritiesRepositoryImpl extends UserFavoritiesRepository{
  @override
  Future<Either<Failure, void>> addToStorage(String movieId) {
    // TODO: implement addToStorage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeFromStorage(String movieId) {
    // TODO: implement removeFromStorage
    throw UnimplementedError();
  }

}