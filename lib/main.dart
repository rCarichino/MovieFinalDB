import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedb/core/routes/app_routes.dart';
import 'core/resources/styles.dart';
import 'dependencies_injection.dart';
import 'features/movie/presentation/list/cubits/list_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await serviceLocator();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<ListCubit>(),
        child: SafeArea(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Movie DB',
            theme: themeLight(context),
            routerConfig: AppRoute.router,
          ),
        ));
  }
}
