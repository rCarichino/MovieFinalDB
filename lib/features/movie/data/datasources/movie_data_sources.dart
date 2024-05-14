import 'package:dartz/dartz.dart';
import 'package:moviedb/core/api/dio_client.dart';
import 'package:moviedb/core/api/list_api.dart';
import 'package:moviedb/core/error/failure.dart';

import '../../domain/entities/search_params.dart';
import '../models/movie_model.dart';

abstract class MovieDataSources {
  Future<Either<Failure, List<MovieModel>>> getListMovies(
      SearchParams searchParams);

  Future<Either<Failure, List<MovieModel>>> getSearchedMovie(
      SearchParams searchParams);
}

class MovieDataSourcesImpl extends MovieDataSources {
  final DioClient _client;

  MovieDataSourcesImpl(this._client);

  @override
  Future<Either<Failure, List<MovieModel>>> getListMovies(
      SearchParams searchParams) async {
    return await _client.getRequest(ListApi.kDiscoverMoviePath,
        converter: (response) {
      List<MovieModel> listMovie = response.map((movie) {
        return MovieModel.fromJson(movie);
      }).toList();
      return listMovie;
    }, queryParameters: searchParams.toJson());
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getSearchedMovie(
      SearchParams searchParams) async {
    return await _client.getRequest(ListApi.kSearchMoviePath,
        converter: (response) {
      List<MovieModel> listMovie = response.map((movie) {
        return MovieModel.fromJson(movie);
      }).toList();
      return listMovie;
    }, queryParameters: searchParams.toJson());
  }
}
