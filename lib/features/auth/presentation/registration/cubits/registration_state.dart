part of 'registration_cubit.dart';

class RegistrationState extends Equatable {

 final AuthParams authParams;
 final UserCredential? userCredential;
 final String error;

  const RegistrationState({required this.authParams,required this.userCredential,required this.error});

  factory RegistrationState.initial() {
    return RegistrationState(authParams: AuthParams(),userCredential: null, error: "");
  }

  RegistrationState copyWith({AuthParams? authParams, UserCredential? userCredential, String? error}){
    return RegistrationState(authParams: authParams ?? this.authParams,userCredential: userCredential ?? this.userCredential,error: error ?? this.error);
  }

  @override
  List<Object?> get props => [authParams];
}
