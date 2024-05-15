import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/usecase/usecase.dart';
import 'package:moviedb/features/movie/domain/entities/movie.dart';
import 'package:moviedb/features/movie/domain/entities/search_params.dart';
import 'package:moviedb/features/movie/domain/repositories/movie_repository.dart';

class GetListMovie extends UseCase< List<Movie>, SearchParams>{

  final MovieRepository movieRepository;
  GetListMovie(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(SearchParams params)  => movieRepository.fetchListMovies(params);


}