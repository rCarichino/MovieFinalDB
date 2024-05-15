import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/auth/presentation/registration/registration_page.dart';
import 'package:moviedb/features/movie/presentation/details/detail_page.dart';
import 'package:moviedb/features/movie/presentation/list/list_page.dart';
import 'package:moviedb/features/profile/presentation/profile/profile_page.dart';
import 'package:moviedb/features/splashscreen/splash_screen_page.dart';

import '../../features/auth/presentation/login/login_page.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),
  login("/auth/login"),
  register("/auth/registration"),
  details("/details/:id"),
  profile("/profile"),
  home("/home");

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext context) {
    context = context;
  }

  static final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: Routes.splashScreen.path,
          name: Routes.splashScreen.name,
          builder: (context, state) => SplashScreenPage(),
        ),
        GoRoute(
          path: Routes.root.path,
          name: Routes.root.name,
          redirect: (context, state) => Routes.home.path,
        ),
        GoRoute(
            path: Routes.register.path,
            name: Routes.register.name,
            builder: (context, state) => const RegistrationPage()),
        GoRoute(
            path: Routes.profile.path,
            name: Routes.profile.name,
            builder: (context, state) => const ProfilePage()),
        GoRoute(
            path: Routes.login.path,
            name: Routes.login.name,
            builder: (context, state) => const LoginPage()),
        GoRoute(
            path: Routes.details.path,
            name: Routes.details.name,
            builder: (context, state) =>
                DetailPage(id: state.pathParameters["id"]!)),
        GoRoute(
          path: Routes.home.path,
          name: Routes.home.name,
          builder: (context, state) => const ListPage(),
        ),
      ],
      initialLocation: Routes.splashScreen.path,
      routerNeglect: true,
      debugLogDiagnostics: kDebugMode,

      redirect: (_, state) {
        final bool isLoginPage = state.matchedLocation == Routes.login.path ||
            state.matchedLocation == Routes.register.path;
        if (isLoginPage) {
          return Routes.root.path;
        }
        return null;
      }
      );
}
