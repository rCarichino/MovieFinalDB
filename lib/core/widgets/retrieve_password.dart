import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';

void retrievePassword(BuildContext context) {
  final conEmail = TextEditingController();

  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
                style: Theme.of(context).textTheme.labelLarge,
                "Insert your email"),
            content: TextField(
              controller: conEmail,
            ),
            actions: [
              CupertinoDialogAction(
                  child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      "Send email"),
                  onPressed: () =>
                      context.read<LoginCubit>().changePassword(conEmail.text))
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                style: Theme.of(context).textTheme.labelLarge,
                "Insert your email"),
            content: TextField(
              controller: conEmail,
            ),
            actions: [
              TextButton(
                  child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      "Send email"),
                  onPressed: () {
                      context.read<LoginCubit>().changePassword(conEmail.text);
                      Navigator.pop(context);
                  }
                  ),
            ],
          );
        });
  }
}
