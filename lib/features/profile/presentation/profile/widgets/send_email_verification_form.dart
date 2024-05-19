import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/widgets/button.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';
import 'package:moviedb/utils/validator.dart';

class SendEmailVerificationForm extends StatefulWidget {
  const SendEmailVerificationForm({super.key});

  @override
  State<SendEmailVerificationForm> createState() =>
      _SendEmailVerificationFormState();
}

class _SendEmailVerificationFormState extends State<SendEmailVerificationForm> {
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
            Text("Change password with email link"),
            if (!context.watch<ProfileCubit>().state.user!.emailVerified)
              Column(
                children: [
                  Text(
                      "Email will be sent to: ${context.read<ProfileCubit>().state.user?.email}\nIn order to receive the link, email must be verified"),
                  ElevatedButton(
                      onPressed: () async {
                        await _sendEmailVerification(context);
                      },
                      child: const Text("Verify")),
                ],
              )
            else
              Column(
                children: [
                  const Text(
                      "Email is already verified, you can insert current password"),
                  TextFormField(
                    controller: _conPassword,
                    validator: (String? value) =>
                        isValidPassword(value) ? value : null,
                    decoration:
                        const InputDecoration(hintText: "Actual password"),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<ProfileCubit>()
                              .doReset(password: _conPassword.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Email sent")));
                        }
                      },
                      child: const Text("Send Email"))
                ],
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _sendEmailVerification(context) async {
  String text = '';
  if (!FirebaseAuth.instance.currentUser!.emailVerified) {
    text = 'Email Link Sent';
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  } else {
    text = 'Email Already Verified';
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
