import 'package:get_it/get_it.dart';
import 'package:moviedb/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:moviedb/features/auth/domain/repositories/auth_repository.dart';
import 'package:moviedb/features/auth/domain/usecases/create_user.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:moviedb/features/auth/presentation/registration/cubits/registration_cubit.dart';
import 'package:moviedb/features/movie/data/datasources/movie_data_sources.dart';
import 'package:moviedb/features/movie/presentation/list/cubits/list_cubit.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';

import 'core/api/dio_client.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/get_popular_movie.dart';
import 'features/movie/domain/usecases/get_searched_movie.dart';

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

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}

/// Register dataSources
void _dataSources() {
  getIt.registerLazySingleton<MovieDataSources>(
    () => MovieDataSourcesImpl(getIt()),
  );
}

void _useCase() {
  getIt.registerLazySingleton(() => GetListMovie(getIt()));
  getIt.registerLazySingleton(() => GetSearchedMovie(getIt()));
  getIt.registerLazySingleton(() => CreateUser(getIt()));
  getIt.registerLazySingleton(() => LoginUser(getIt()));
}

void _cubit() {
  getIt.registerFactory(
      () => ListCubit(getPopularMovie: getIt(), getSearchedMovie: getIt()));

  getIt.registerFactory(() => LoginCubit(loginUser: getIt()));
  getIt.registerFactory(() => RegistrationCubit(createUser: getIt()));
  getIt.registerFactory(() => ProfileCubit());
}
