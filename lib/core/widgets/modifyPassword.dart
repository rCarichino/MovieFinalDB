import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/widgets/spacer_v.dart';
import 'package:moviedb/core/widgets/text_f.dart';

import '../../features/profile/presentation/profile/cubits/profile_cubit.dart';
import '../../utils/validator.dart';
import '../resources/palette.dart';

class ModifyPassword extends StatelessWidget {
  const ModifyPassword({
    super.key,
    required FocusNode fnPassword,
    required TextEditingController conPassword,
    required GlobalKey<FormState> formKey,
  }) : _fnPassword = fnPassword, _conPassword = conPassword, _formKey = formKey;

  final FocusNode _fnPassword;
  final TextEditingController _conPassword;
  final GlobalKey<FormState> _formKey;

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
        TextF(
          autofillHints: const [AutofillHints.password],
          key: const Key("password"),
          curFocusNode: _fnPassword,
          textInputAction: TextInputAction.done,
          controller: _conPassword,
          keyboardType: TextInputType.text,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          obscureText: true,
          hintText: 'Current password',
          maxLine: 1,
          hint: "password",
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () => context
                .read<ProfileCubit>()
                .toggleShowPassword(),
          ),
          validator: (String? value) =>
          isValidPassword(value) ? value : null,
        ),
        const SpacerV(),
        ElevatedButton(
            style: const ButtonStyle(
              backgroundColor:
              WidgetStatePropertyAll(Palette.primary),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await context
                    .read<ProfileCubit>()
                    .doReset(password: _conPassword.text);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email sent")));
              }
            },
            child: const Text(
                style: TextStyle(
                  color: Palette.background,
                  fontFamily: "Poppins",
                ),
                "Send Email"))
      ],
    );
  }
}