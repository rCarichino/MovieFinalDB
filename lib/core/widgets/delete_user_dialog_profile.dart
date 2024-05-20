import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/profile/presentation/profile/cubits/profile_cubit.dart';

void deleteUserDialog(BuildContext context) {
  final conPassword = TextEditingController();

  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
                style: Theme.of(context).textTheme.labelLarge,
                "Insert Current Password"),
            content: TextField(
              controller: conPassword,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                    style: Theme.of(context).textTheme.labelLarge,
                    "Delete account"),
                onPressed: () => context
                    .read<ProfileCubit>()
                    .doDelete(password: conPassword.text),
              )
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text(
                style: Theme.of(context).textTheme.labelLarge,
                "Insert current password"),
            content: TextField(
              controller: conPassword,
            ),
            actions: [
              TextButton(
                child: Text(
                    style: Theme.of(context).textTheme.labelLarge,

                    "Delete account"),
                onPressed: () => context
                    .read<ProfileCubit>()
                    .doDelete(password: conPassword.text.trim()),
              )
            ],
          );
        });
  }
}
