import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/movie/presentation/details/detail_page.dart';
import 'package:moviedb/features/movie/presentation/list/list_page.dart';
import 'package:moviedb/features/splashscreen/splash_screen_page.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),
  login("/auth/login"),
  register("/auth/registration"),
  details("/details/:id"),
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
          builder: (context, state) => Container()),
      GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          builder: (context, state) => Container()),
      GoRoute(
          path: Routes.details.path,
          name: Routes.details.name,
          builder: (context, state) => DetailPage()),
      //DetailsPage(id: state.pathParameters["id"]!)),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        builder: (context, state) => ListPage(),
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
  );
}
