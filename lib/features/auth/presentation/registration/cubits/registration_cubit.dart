import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/auth/domain/entities/auth_params.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/create_user.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  CreateUser createUser;

  RegistrationCubit({required this.createUser})
      : super(RegistrationState.initial());

  Future<void> registration(
      {required String email, required String password}) async {
    final authParams = AuthParams(email: email, password: password);
    final userCredential = await createUser.call(authParams);
    userCredential.fold(
        (failure) => emit(state.copyWith(error: (failure as ServerFailure).message)),
        (userCredential) => emit(state.copyWith(authParams: authParams,userCredential: userCredential)));
  }
}
