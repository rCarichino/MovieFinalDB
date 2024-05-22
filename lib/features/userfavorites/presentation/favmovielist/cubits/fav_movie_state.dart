part of 'fav_movie_cubit.dart';

class FavMovieState extends Equatable {
  final List<UserFavEnt> movies;
  final bool isLoading;
  final String? errorMessage;

  const FavMovieState({
    required this.movies,
    required this.isLoading,
    required this.errorMessage,
  });

  factory FavMovieState.initial() {
    return const FavMovieState(
      movies: [],
      isLoading: true,
      errorMessage: '');
  }

  FavMovieState copyWith({
    List<UserFavEnt>? movies,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavMovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [movies, isLoading, errorMessage];
}