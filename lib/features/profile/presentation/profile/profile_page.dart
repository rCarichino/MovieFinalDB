import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../auth/presentation/login/cubits/login_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.titleLarge),
                "Profile"),
          ],
        ),
        actions: [
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              context.read<LoginCubit>().logoutUser();
              print(context.read<LoginCubit>().state.user);
            },
            child: IconButton(
                onPressed: () {
                  _signOut(context);
                },
                icon: Icon(Icons.logout, size: Dimens.selectedIndicatorW)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
                onPressed: () => context.goNamed(Routes.profile.name),
              ),
              label: "Profile")
        ],
        currentIndex: _selectedIndex(context),
        selectedItemColor: Colors.red[800],
      ),
      body: Text(FirebaseAuth.instance.currentUser!.email ?? "Non sei loggato"),
    );
  }
}

int _selectedIndex(BuildContext context) {
  final currentLocation = ModalRoute.of(context)!.settings.name!;
  if (currentLocation == "profile") {
    return 1;
  }
  return 0;
}

Future<void> _signOut(BuildContext context) async {
  print(context.read<LoginCubit>().state.user);
  context.read<ProfileCubit>().signOutUser();
  await FirebaseAuth.instance.signOut();
  print(context.read<LoginCubit>().state.user);

}
