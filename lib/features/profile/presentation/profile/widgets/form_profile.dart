import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'package:moviedb/utils/validator.dart';

class FormProfile extends StatefulWidget {
  const FormProfile({super.key});

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  final _formKey = GlobalKey<FormState>();

  final _conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Change password with email verification"),
            Text(
                "Email will be sent to:\n${context.read<ProfileCubit>().state.user?.email}"),
            TextFormField(
              controller: _conPassword,
              validator: (String? value) =>
                  isValidPassword(value) ? value : null,
              decoration: const InputDecoration(hintText: "Actual password"),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await context
                        .read<ProfileCubit>()
                        .doReset(password: _conPassword.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Email sent")));
                  }
                },
                child: const Text("VALIDATE"))
          ],
        ),
      ),
    );
  }
}
