import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fav_movie_state.dart';

class FavMovieCubit extends Cubit<FavMovieState> {
  FavMovieCubit() : super(FavMovieInitial());
}
