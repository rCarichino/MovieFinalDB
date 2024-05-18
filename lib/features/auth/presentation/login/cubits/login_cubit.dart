import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/auth_params.dart';
import '../../../domain/usecases/login_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;

  LoginCubit({required this.loginUser}) : super(LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    final authParams = AuthParams(email: email, password: password);
    final user = await loginUser.call(authParams);
    user.fold(
        (failure) =>
            emit(state.copyWith(error: (failure as ServerFailure).message)),
        (user) => emit(state.copyWith(authParams: authParams, user: user)));
  }

  void toggleShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  void logoutUser() {
    emit(state.copyWith(user: null));
  }

  bool isLoggedIn(){
    return state.user == null ? true : false;
}
}
