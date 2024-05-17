import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';

import '../entities/movie.dart';
import '../entities/search_params.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> fetchListMovies(
      SearchParams searchParams);

  Future<Either<Failure, List<Movie>>> fetchSearchedMovies(
      SearchParams searchParams);
}
