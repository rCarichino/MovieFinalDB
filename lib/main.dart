import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedb/core/routes/app_routes.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:moviedb/features/auth/presentation/registration/cubits/registration_cubit.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'core/resources/styles.dart';
import 'dependencies_injection.dart';
import 'features/movie/presentation/list/cubits/list_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await serviceLocator();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<ListCubit>(),

        ),
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegistrationCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileCubit>(),
        ),
      ],
      child: SafeArea(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Movie DB',
          theme: themeLight(context),
          routerConfig: AppRoute.router,
        ),
      ),
    );
  }
}
