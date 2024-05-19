import 'package:flutter/material.dart';

import '../../../../../core/resources/dimens.dart';
import '../../../../../core/resources/palette.dart';
import '../../../../../core/widgets/button.dart';
import 'delete_user_dialog_profile.dart';

class DeleteUserSection extends StatelessWidget {
  const DeleteUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(right: 25, left: 10, top: 10),
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
      )
    ]);
  }
}
