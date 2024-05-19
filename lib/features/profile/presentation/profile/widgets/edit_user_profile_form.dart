import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'package:moviedb/utils/validator.dart';

class EditUserProfileForm extends StatefulWidget {
  const EditUserProfileForm({super.key});

  @override
  State<EditUserProfileForm> createState() => _EditUserProfileFormState();
}

class _EditUserProfileFormState extends State<EditUserProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conImageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _conUserName,
                validator: (String? value) =>
                    validateUserName(value) ? value : null,
                decoration: InputDecoration(hintText: "${context.watch<ProfileCubit>().state.user!.displayName}"),
              ),
              TextFormField(
                controller: _conImageUrl,
                decoration: InputDecoration(hintText: "${context.watch<ProfileCubit>().state.user!.photoURL}"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<ProfileCubit>().doEditProfile(
                        userName: _conUserName.text, url: _conImageUrl.text);
                  },
                  child: Text("Modifica"))
            ],
          ),
        ));
  }

}
