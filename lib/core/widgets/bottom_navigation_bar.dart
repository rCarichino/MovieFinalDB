import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';

BottomNavigationBar bottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => context.goNamed(Routes.home.name),
            icon: const Icon(Icons.movie),
          ),
          label: "Movies"),
      BottomNavigationBarItem(
          icon: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                context.goNamed(Routes.profile.name);
              }
          ),
          label: "Profile"),
      BottomNavigationBarItem(
          icon: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                context.goNamed(Routes.userFavMovies.name);
              }
          ),
          label: "Favorities")
    ],
    currentIndex: _selectedIndex(context),
    selectedItemColor: Colors.red[800],
  );
}


int _selectedIndex(BuildContext context) {
  final currentLocation = ModalRoute.of(context)!.settings.name!;
  if (currentLocation == "home") {
    return 0;
  }
  if(currentLocation == "userFavMovies"){
    return 2;
  }
  return 1;
}
