part of 'list_cubit.dart';

class ListState extends Equatable {
  final bool isLoading;
  final List<Movie> movie;
  final String error;
  final bool isGrid;

  const ListState(
      {required this.isLoading,
      required this.isGrid,
      required this.movie,
      required this.error});

  factory ListState.initial() {
    return const ListState(
        isLoading: false, movie: [], error: "", isGrid: true);
  }

  ListState copyWith({bool? isLoading, List<Movie>? movie, String? error, bool? isGrid}) {
    return ListState(
        isLoading: isLoading ?? this.isLoading,
        movie: movie ?? this.movie,
        error: error ?? this.error,
        isGrid: isGrid ?? this.isGrid);
  }

  @override
  List<Object?> get props => [isLoading, movie, error, isGrid];
}
