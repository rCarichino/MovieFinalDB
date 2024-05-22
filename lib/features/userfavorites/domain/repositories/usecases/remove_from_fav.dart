import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/userfavorites/domain/entities/user_fav_ent.dart';

import '../user_fav_repository.dart';

class RemoveFromFav extends UseCase<void, UserFavEnt> {
  final UserFavoritiesRepository userFavoritiesRepository;

  RemoveFromFav(this.userFavoritiesRepository);

  @override
  Future<Either<Failure, void>> call(UserFavEnt params) =>
      userFavoritiesRepository.removeFromStorage(params);
}
