import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/widgets/text_f.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'package:moviedb/utils/validator.dart';

import '../resources/dimens.dart';
import '../resources/palette.dart';

class EditUserProfileForm extends StatefulWidget {
  const EditUserProfileForm({super.key});

  @override
  State<EditUserProfileForm> createState() => _EditUserProfileFormState();
}

class _EditUserProfileFormState extends State<EditUserProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conImageUrl = TextEditingController();

  bool userNameFieldDisplayed = false;
  bool imageUrlFieldDisplayed = false;

  @override
  void dispose() {
    _conUserName.dispose();
    _conImageUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(Dimens.space3 + Dimens.space2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      userNameFieldDisplayed = !userNameFieldDisplayed;
                    });
                  },
                  child: Text(
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Palette.textDark),
                      context.watch<ProfileCubit>().state.user?.displayName ??
                          'Username still not set')),
              Visibility(
                visible: userNameFieldDisplayed,
                child: TextF(
                    controller: _conUserName,
                    validator: (String? value) =>
                        validateUserName(value) ? "error" : null,
                    hint: "Modifica Username",
                    hintText:
                        context.watch<ProfileCubit>().state.user?.displayName ??
                            "",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    )),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      imageUrlFieldDisplayed = !imageUrlFieldDisplayed;
                    });
                  },
                  child: SizedBox(
                    width: Dimens.imageW,
                    child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: context
                                .watch<ProfileCubit>()
                                .state
                                .user
                                ?.photoURL ??
                            'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'),
                  )),
              Visibility(
                visible: imageUrlFieldDisplayed,
                child: TextF(
                  controller: _conUserName,
                  validator: (String? value) =>
                      validateUserName(value) ? "error" : null,
                  hint: "Modifica ProfileUrl",
                  hintText: "Inserisci l'url",
                  prefixIcon: Icon(
                    Icons.photo,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              Visibility(
                visible: imageUrlFieldDisplayed || userNameFieldDisplayed,
                child: ElevatedButton(
                    onPressed: () {
                      showEditingSnackbarAndDoEdit(
                          userName: _conUserName.text.trim(),
                          imageUrl: _conImageUrl.text.trim(),
                          context: context);
                      _conImageUrl.clear();
                      _conUserName.clear();
                    },
                    child: const Text(
                        style: TextStyle(fontFamily: "Poppins"), "Modifica")),
              )
            ],
          ),
        ));
  }
}

void showEditingSnackbarAndDoEdit({
  required String userName,
  required String imageUrl,
  required BuildContext context,
}) {
  String newImageUrl = imageUrl.isNotEmpty
      ? "${Uri.parse(imageUrl).host}/${Uri.parse(imageUrl).pathSegments.first}"
      : '';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Editing: ${userName.isNotEmpty ? 'Username: $userName' : ''}\n${imageUrl.isNotEmpty ? 'Image: $newImageUrl' : ''}",
      ),
    ),
  );
  context.read<ProfileCubit>().doEditProfile(userName: userName, url: imageUrl);
}
