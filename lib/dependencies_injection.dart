
import 'package:get_it/get_it.dart';
import 'package:moviedb/features/movie/data/datasources/movie_data_sources.dart';
import 'package:moviedb/features/movie/presentation/list/cubits/list_cubit.dart';

import 'core/api/dio_client.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/post_popular_movie.dart';
import 'features/movie/domain/usecases/post_searched_movie.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocator() async {
  getIt.registerSingleton<DioClient>(DioClient());
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}


/// Register repositories
void _repositories() {
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt()),
  );
}

/// Register dataSources
void _dataSources() {
  getIt.registerLazySingleton<MovieDataSources>(
    () => MovieDataSourcesImpl(getIt()),
  );
}

void _useCase() {
  /// Auth
  getIt.registerLazySingleton(() => PostListMovie(getIt()));
  getIt.registerLazySingleton(() => PostSearchedMovie(getIt()));

}

void _cubit() {
  getIt.registerFactory(() => ListCubit(postPopularMovie: getIt(), postSearchedMovie: getIt()));
}
