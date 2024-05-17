part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool showPassword;
  final AuthParams authParams;
  final User? user;
  final String error;

  const LoginState(
      {required this.showPassword,
      required this.authParams,
      required this.user,
      required this.error});

  factory LoginState.initial() => LoginState(
      showPassword: true, authParams: AuthParams(), user: null, error: "");

  LoginState copyWith(
      {bool? showPassword, AuthParams? authParams, User? user, String? error}) {
    return LoginState(
        showPassword: showPassword ?? this.showPassword,
        authParams: authParams ?? this.authParams,
        user: user,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [showPassword, authParams, user, error];
}
