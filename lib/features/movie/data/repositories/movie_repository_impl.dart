import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movie/data/datasources/movie_data_sources.dart';
import 'package:moviedb/features/movie/data/models/movie_model.dart';
import 'package:moviedb/features/movie/domain/entities/movie.dart';
import 'package:moviedb/features/movie/domain/entities/search_params.dart';

import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDataSources movieDataSources;

  MovieRepositoryImpl(this.movieDataSources);

  Movie movieToEnt(MovieModel movieModel) {
    return Movie(
        id: movieModel.id,
        adult: movieModel.adult,
        title: movieModel.title,
        originalTitle: movieModel.originalTitle,
        originalLanguage: movieModel.originalLanguage,
        overview: movieModel.overview,
        posterPath: movieModel.posterPath,
        releaseDate: movieModel.releaseDate,
        genreIds: movieModel.genreIds,
        video: movieModel.video);
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchListMovies(
      SearchParams searchParams) async {
    final response = await movieDataSources.getListMovies(searchParams);
    return response.fold((failure) => Left(failure), (response) {
      List<Movie> movieList =
          response.map((movieModel) => movieToEnt(movieModel)).toList();
      return Right(movieList);
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchSearchedMovies(
      SearchParams searchParams) async {
    final response = await movieDataSources.getSearchedMovie(searchParams);
    return response.fold((failure) => Left(failure), (response) {
      List<Movie> movieList =
          response.map((movieModel) => movieToEnt(movieModel)).toList();
      return Right(movieList);
    });
  }
}
