import 'package:flutter/material.dart';
import 'package:moviedb/core/routes/app_routes.dart';

import 'features/movie/presentation/list/cubits/list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(postPopularMovie: postPopularMovie, postSearchedMovie: postSearchedMovie),
      child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRoute.router,
      ),
    );
  }
}

