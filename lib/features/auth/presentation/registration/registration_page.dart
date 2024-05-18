import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:moviedb/features/auth/presentation/registration/cubits/registration_cubit.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/spacer_v.dart';
import '../../../../core/widgets/text_f.dart';
import '../../../../utils/validator.dart';
import '../../../profile/presentation/profile/cubits/profile_cubit.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  /// Controller
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: Dimens.space12),
            child: Text(
              "Registration",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          leading: IconButton(
              onPressed: () => context.goNamed(Routes.login.name),
              icon: const Icon(Icons.arrow_back))),
      body: BlocConsumer<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
        if (state.error.isNotEmpty) {
          showToast(state.error);
        }
        context.read<LoginCubit>().login(
              email: _conEmail.text,
              password: _conPassword.text,
            );
        context.read<ProfileCubit>().getCurrentUser();
        context.goNamed(Routes.home.name);
      }, builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: AutofillGroup(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).hintColor,
                        radius: Dimens.profilePicture + Dimens.space4,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(Images.icLauncher),
                          radius: Dimens.profilePicture,
                        ),
                      ),
                      const SpacerV(),
                      TextF(
                        autofillHints: const [AutofillHints.email],
                        key: const Key("email"),
                        curFocusNode: _fnEmail,
                        nextFocusNode: _fnPassword,
                        textInputAction: TextInputAction.next,
                        controller: _conEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        hintText: "example@example.com",
                        hint: "email",
                        validator: (String? value) => validateEmail(value),
                      ),
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
                        obscureText: state.showPassword,
                        hintText: '••••••••••••',
                        maxLine: 1,
                        hint: "password",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () => context
                              .read<RegistrationCubit>()
                              .toggleShowPassword(),
                        ),
                        validator: (String? value) =>
                            isValidPassword(value) ? value : null,
                      ),
                      SpacerV(value: Dimens.space24),
                      Button(
                        title: "Register",
                        onPressed: () async {
                          if (_keyForm.currentState?.validate() ?? false) {
                            await context
                                .read<RegistrationCubit>()
                                .registration(
                                  email: _conEmail.text,
                                  password: _conPassword.text,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
