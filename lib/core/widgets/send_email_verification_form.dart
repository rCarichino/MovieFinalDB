import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/resources/palette.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';

import 'modify_password.dart';
import 'spacer_v.dart';

class SendEmailVerificationForm extends StatefulWidget {
  const SendEmailVerificationForm({super.key});

  @override
  State<SendEmailVerificationForm> createState() =>
      _SendEmailVerificationFormState();
}

class _SendEmailVerificationFormState extends State<SendEmailVerificationForm> {
  final _keyForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                style: Theme.of(context).textTheme.headlineSmall,
                "Change password with email link"),
            if (!context.watch<ProfileCubit>().state.user!.emailVerified)
              Column(
                children: [
                  Text(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                      "Email will be sent to: ${context.read<ProfileCubit>().state.user?.email}\nIn order to receive the link, email must be verified"),
                  const SpacerV(),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Palette.primary)),
                      onPressed: () async {
                        await _sendEmailVerification(context);
                      },
                      child: Text(
                          style: Theme.of(context).textTheme.labelMedium,
                          "Verify")),
                ],
              )
            else const ModifyPassword(),
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
