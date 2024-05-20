part of 'fav_movie_cubit.dart';

sealed class FavMovieState extends Equatable {
  const FavMovieState();
}

final class FavMovieInitial extends FavMovieState {
  @override
  List<Object> get props => [];
}
