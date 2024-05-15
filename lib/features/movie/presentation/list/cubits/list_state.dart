part of 'list_cubit.dart';

class ListState extends Equatable {

  final bool isLoading;
  final List<Movie> movie;
  final String error;

  const ListState({ required this.isLoading, required this.movie, required this.error});

  factory ListState.initial() {
    return const ListState(isLoading: false, movie: [], error: "");
  }

  ListState copyWith({bool? isLoading, List<Movie>? movie, String? error}){
   return ListState(isLoading: isLoading ?? this.isLoading, movie: movie ?? this.movie, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [isLoading,movie,error];
}

