import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  void getCurrentUser() =>
      emit(state.copyWith(user: FirebaseAuth.instance.currentUser));

  void signOutUser() => emit(state.copyWith(user: null));
}
