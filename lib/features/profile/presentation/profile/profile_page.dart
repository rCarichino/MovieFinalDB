import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/widgets/button.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'package:moviedb/features/profile/presentation/profile/widgets/container_profile.dart';
import 'package:moviedb/features/profile/presentation/profile/widgets/delete_user_dialog_profile.dart';
import 'package:moviedb/features/profile/presentation/profile/widgets/send_email_verification_form.dart';
import 'package:moviedb/features/profile/presentation/profile/widgets/edit_user_profile_form.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/palette.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
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
              Text(style: Theme.of(context).textTheme.titleLarge, "Profile"),
            ],
          ),
          actions: [
            BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {
                //Solo nel caso in cui lo state.user viene settato a null
                if (state.user == null) {
                  context.read<LoginCubit>().logoutUser();
                  context.goNamed(Routes.login.name);
                }
              },
              child: IconButton(
                  onPressed: () {
                    _signOut(context);
                  },
                  icon: Icon(Icons.logout, size: Dimens.selectedIndicatorW)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContainerProfile(
                dimens: MediaQuery.of(context).size.height * 0.40,
                palette: Palette.cardDark,
                child: const EditUserProfileForm(),
              ),
              ContainerProfile(
                dimens: MediaQuery.of(context).size.height * 0.25,
                palette: Palette.background,
                child: const SendEmailVerificationForm(),
              ),
              ContainerProfile(
                dimens: MediaQuery.of(context).size.height * 0.181,
                palette: Palette.card,
                child: Column(
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.only(right: 25, left: 10, top: 10),
                        height: 120,
                        child: SingleChildScrollView(
                            child: Text(
                                style: Theme.of(context).textTheme.labelMedium,
                                "Are you sure you want to delete your account? This action is permanent and cannot be undone."
                                "\nDeleting your account will result in the following:"
                                "\nAll your data, including personal information, preferences, and saved content, will be permanently erased."
                                "\nYou will lose access to all services and features associated with your account."
                                "\nAny ongoing subscriptions or memberships will be canceled, and any remaining balance or credits will be forfeited."))),
                    Button(
                      width: Dimens.buttonH,
                      title: 'Delete Account',
                      color: Palette.redLatte,
                      onPressed: () {
                        deleteUserDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(context));
  }
}

Future<void> _signOut(BuildContext context) async {
  context.read<ProfileCubit>().signOutUser();
  await FirebaseAuth.instance.signOut();
}
