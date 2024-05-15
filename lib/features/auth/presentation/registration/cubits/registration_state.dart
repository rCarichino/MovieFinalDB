part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  final bool showPassword;
  final AuthParams authParams;
  final UserCredential? userCredential;
  final String error;

  const RegistrationState(
      {required this.showPassword,
      required this.authParams,
      required this.userCredential,
      required this.error});

  factory RegistrationState.initial() {
    return RegistrationState(
        showPassword: true,
        authParams: AuthParams(),
        userCredential: null,
        error: "");
  }

  RegistrationState copyWith(
      {bool? showPassword,
      AuthParams? authParams,
      UserCredential? userCredential,
      String? error}) {
    return RegistrationState(
        showPassword: showPassword ?? this.showPassword,
        authParams: authParams ?? this.authParams,
        userCredential: userCredential ?? this.userCredential,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [showPassword, authParams, userCredential, error];
}
