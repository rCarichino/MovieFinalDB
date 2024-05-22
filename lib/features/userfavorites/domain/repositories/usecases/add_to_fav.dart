import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/userfavorites/domain/entities/user_fav_ent.dart';
import 'package:moviedb/features/userfavorites/domain/repositories/user_fav_repository.dart';

class AddToFav extends UseCase<void, UserFavEnt> {
  final UserFavoritiesRepository userFavoritiesRepository;

  AddToFav(this.userFavoritiesRepository);

  @override
  Future<Either<Failure, void>> call(UserFavEnt params) =>
      userFavoritiesRepository.addToStorage(params);
}
