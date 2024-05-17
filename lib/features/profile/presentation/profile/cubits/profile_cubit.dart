import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:moviedb/features/profile/presentation/profile/profile_page.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  void signOutUser() {
    emit(state.copyWith(user: null));
  }
}
