import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/userfavorites/domain/entities/user_fav_ent.dart';
import 'package:moviedb/features/userfavorites/domain/repositories/user_fav_repository.dart';

class GetFromFav extends UseCase<List<UserFavEnt>, UserFavEnt> {
  final UserFavoritiesRepository userFavoritiesRepository;

  GetFromFav(this.userFavoritiesRepository);

  @override
  Future<Either<Failure, List<UserFavEnt>>> call(params) =>
      userFavoritiesRepository.getFromStorage(params);
}
