import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/auth/presentation/registration/registration_page.dart';
import 'package:moviedb/features/movie/presentation/details/detail_page.dart';
import 'package:moviedb/features/movie/presentation/list/list_page.dart';
import 'package:moviedb/features/profile/presentation/profile/profile_page.dart';
import 'package:moviedb/features/splashscreen/splash_screen_page.dart';
import 'package:moviedb/features/userfavorites/presentation/favmovielist/fav_movie_page.dart';

import '../../features/auth/presentation/login/login_page.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),
  login("/auth/login"),
  register("/auth/registration"),
  details("/details/:id"),
  profile("/profile"),
  home("/home"),
  userFavMovies('/userFavMovies');

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext context) {
    context = context;
  }

  static final router = GoRouter(
      routes: [
        GoRoute(
          path: Routes.splashScreen.path,
          name: Routes.splashScreen.name,
          builder: (context, state) => const SplashScreenPage(),
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
        GoRoute(
          path: Routes.userFavMovies.path,
          name: Routes.userFavMovies.name,
          builder: (context, state) => const FavMoviePage(),
        ),
      ],
      initialLocation: Routes.splashScreen.path,
      routerNeglect: true,
      debugLogDiagnostics: kDebugMode,
      redirect: (context, state) {
        final bool isHomePage = state.matchedLocation == Routes.home.path;

        if (isHomePage && FirebaseAuth.instance.currentUser == null) {
          return Routes.login.path;
        }

        final bool isProfilePage = state.matchedLocation == Routes.profile.path;

        if (isProfilePage && FirebaseAuth.instance.currentUser == null) {
          return Routes.login.path;
        }
      });
}
