import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/userfavorites/domain/entities/user_fav_ent.dart';

import '../../../domain/usecases/add_to_fav.dart';
import '../../../domain/usecases/get_from_fav.dart';
import '../../../domain/usecases/remove_from_fav.dart';

part 'fav_movie_state.dart';

class FavMovieCubit extends Cubit<FavMovieState> {
  final AddToFav addToFav;
  final RemoveFromFav removeFromFav;
  final GetFromFav getFromFav;

  FavMovieCubit(
      {required this.removeFromFav,
      required this.getFromFav,
      required this.addToFav})
      : super(FavMovieState.initial());

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addToFavList(
      {required String movieName, required String movieId}) async {
    final userFavEnt =
        UserFavEnt(movieId: movieId, movieName: movieName, userIds: [userId]);
    await addToFav.call(userFavEnt);
  }

  Future<void> removeFromFavlist({required String movieName}) async {
    final userFavEnt = UserFavEnt(movieName: movieName, userIds: [userId]);
    await removeFromFav.call(userFavEnt);
  }

  Future<void> getFromFavList() async {
    final userFavEnt = UserFavEnt(userIds: [userId]);
    final userFavList = await getFromFav.call(userFavEnt);
    userFavList.fold(
        (failure) => emit(state.copyWith(
            isLoading: false,
            errorMessage: (failure as FirestoreFailure).message)),
        (userFavList) =>
            emit(state.copyWith(isLoading: false, movies: userFavList)));
  }
}
