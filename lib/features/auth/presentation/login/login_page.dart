import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/button_text.dart';
import '../../../../core/widgets/spacer_v.dart';
import '../../../../core/widgets/text_f.dart';
import '../../../../utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showToast(state.error);
        }
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
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (_, state) {
                          return TextF(
                            autofillHints: const [AutofillHints.password],
                            key: const Key("password"),
                            curFocusNode: _fnPassword,
                            textInputAction: TextInputAction.done,
                            controller: _conPassword,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            obscureText: state.showPassword,
                            hintText: '••••••••••••',
                            maxLine: 1,
                            hint: "password",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              onPressed: () => context
                                  .read<LoginCubit>()
                                  .toggleShowPassword(),
                            ),
                            validator: (String? value) =>
                                isValidPassword(value) ? value : null,
                          );
                        },
                      ),
                      SpacerV(value: Dimens.space24),
                      Button(
                        title: "Login",
                        onPressed: () async {
                          if (_keyForm.currentState?.validate() ?? false) {
                            await context.read<LoginCubit>().login(
                                  email: _conEmail.text,
                                  password: _conPassword.text,
                                );
                            context.goNamed(Routes.home.name);
                          }
                        },
                      ),
                      ButtonText(
                        title: "Register",
                        onPressed: () {
                          context.pushNamed(Routes.register.name);
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
