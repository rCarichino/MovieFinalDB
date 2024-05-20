import 'package:flutter/material.dart';

import '../resources/texts.dart';
import '../resources/dimens.dart';
import '../resources/palette.dart';
import 'button.dart';
import 'delete_user_dialog_profile.dart';

class DeleteUserSection extends StatelessWidget {
  const DeleteUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Button(
          width: Dimens.buttonH,
          title: 'Delete Account',
          color: Palette.redLatte,
          onPressed: () {
            deleteUserDialog(context);
          },
        ),
        Container(
            padding: EdgeInsets.only(right: Dimens.space24, left: Dimens.space12, top:  Dimens.space8),
            height: 200,
            child: Text(
                style: Theme.of(context).textTheme.labelMedium,
                Texts.deleteText)),

      ]),
    );
  }
}
