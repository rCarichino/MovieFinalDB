import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/movie/domain/entities/movie.dart';
import 'package:moviedb/features/movie/domain/entities/search_params.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/get_popular_movie.dart';
import '../../../domain/usecases/get_searched_movie.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final GetListMovie getPopularMovie;
  final GetSearchedMovie getSearchedMovie;

  ListCubit({required this.getPopularMovie, required this.getSearchedMovie})
      : super(ListState.initial());

  Future<void> getListMovies({int? page}) async {
    emit(state.copyWith(isLoading: true));
    final searchParams = SearchParams(page: page);
    final data = await getPopularMovie.call(searchParams);
    data.fold(
        (failure) => emit(state.copyWith(
            error: (failure as ServerFailure).message, isLoading: false)),
        (movie) =>
            emit(state.copyWith(movie: movie, isLoading: false, error: "")));
  }

  Future<void> getSearchedMovies(
      {String? query, int? page, String? year}) async {
    emit(state.copyWith(isLoading: true));
    final searchParams = SearchParams(query: query, page: page, year: year);
    final data = await getSearchedMovie.call(searchParams);
    data.fold(
        (failure) => emit(state.copyWith(
            error: (failure as ServerFailure).message, isLoading: false)),
        (movie) =>
            emit(state.copyWith(movie: movie, isLoading: false, error: "")));
  }

  void toggleTypeView() {
    emit(state.copyWith(isGrid: !state.isGrid));
  }
}
