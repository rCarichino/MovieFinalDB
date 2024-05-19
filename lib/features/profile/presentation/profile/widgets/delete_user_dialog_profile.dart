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
            title: const Text(
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
                "Insert Current Password"),
            content: TextField(
              controller: conPassword,
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
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
            title: const Text(
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
                "Insert current password"),
            content: TextField(
              controller: conPassword,
            ),
            actions: [
              TextButton(
                child: const Text(
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
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
