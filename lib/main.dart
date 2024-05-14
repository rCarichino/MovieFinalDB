import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/routes/app_routes.dart';
import 'dependencies_injection.dart';
import 'features/movie/presentation/list/cubits/list_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<ListCubit>(),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRoute.router,
        ));
  }
}
