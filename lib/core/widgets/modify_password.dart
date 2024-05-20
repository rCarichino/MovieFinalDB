import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/widgets/spacer_v.dart';
import 'package:moviedb/core/widgets/text_f.dart';

import '../../features/profile/presentation/profile/cubits/profile_cubit.dart';
import '../../utils/validator.dart';
import '../resources/palette.dart';

class ModifyPassword extends StatefulWidget {
  const ModifyPassword({super.key});

  @override
  State<ModifyPassword> createState() => _ModifyPasswordState();
}

class _ModifyPasswordState extends State<ModifyPassword> {
  final _fnPasswordCurrent = FocusNode();
  final _fnPasswordNew = FocusNode();
  final _conPasswordCurrent = TextEditingController();
  final _conPasswordNew = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
            "Email is already verified, you can insert current password"),
        const SpacerV(),
        AutofillGroup(
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                TextF(
                  autofillHints: const [AutofillHints.password],
                  key: const Key("passwordCurrent"),
                  curFocusNode: _fnPasswordCurrent,
                  textInputAction: TextInputAction.done,
                  controller: _conPasswordCurrent,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  obscureText: context.watch<ProfileCubit>().state.showCurrentPassword,
                  hintText: 'Current password',
                  maxLine: 1,
                  hint: "Current password",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () =>
                        context.read<ProfileCubit>().toggleShowCurrentPassword(),
                  ),
                  validator: (String? value) =>
                      isValidPassword(value) ? value : null,
                ),

                const SpacerV(),

                TextF(
                    autofillHints: const [AutofillHints.password],
                    key: const Key("passwordNew"),
                    curFocusNode: _fnPasswordNew,
                    textInputAction: TextInputAction.done,
                    controller: _conPasswordNew,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    obscureText:
                        context.watch<ProfileCubit>().state.showNewPassword,
                    hintText: 'New password',
                    maxLine: 1,
                    hint: "New password",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () =>
                          context.read<ProfileCubit>().toggleShowNewPassword(),
                    ),
                    validator: (String? value) {
                      if (value != _conPasswordCurrent.text) {
                        return isValidPassword(value) ? value : null;
                      } else {
                        return "The passwords match";
                      }
                    }),

              ],
            ),
          ),
        ),
        const SpacerV(),
        ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Palette.primary),
            ),
            onPressed: () async {
              if (_keyForm.currentState!.validate()) {
                await context
                    .read<ProfileCubit>()
                    .doChangePassword(password:_conPasswordCurrent.text, newPassword: _conPasswordNew.text);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password  Changed")));
              }
            },
            child: const Text(
                style: TextStyle(
                  color: Palette.background,
                  fontFamily: "Poppins",
                ),
                "Change Password"))
      ],
    );
  }
}
