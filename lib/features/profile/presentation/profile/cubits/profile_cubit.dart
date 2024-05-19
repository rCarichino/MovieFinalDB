import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/profile/domain/entities/profile_details_params.dart';

import '../../../domain/entities/reset_params.dart';
import '../../../domain/usecases/do_delete_user.dart';
import '../../../domain/usecases/do_edit_user_profile.dart';
import '../../../domain/usecases/do_reset_params.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DoResetParams doResetParams;
  final DoDeleteUser doDeleteUser;
  final DoEditUserProfile doEditUserProfile;

  ProfileCubit(
      {required this.doEditUserProfile,
      required this.doResetParams,
      required this.doDeleteUser})
      : super(ProfileState.initial());

  void getCurrentUser() =>
      emit(state.copyWith(user: FirebaseAuth.instance.currentUser));

  void signOutUser() => emit(state.copyWith(user: null));

  Future<void> doReset({required String password}) async {
    final ResetParams resetParams = ResetParams(password: password);
    final response = await doResetParams.call(resetParams);
    response.fold((failure) => emit(state.copyWith(user: null)),
        (success) => emit(state.copyWith(user: null)));
  }

  Future<void> doDelete({required String password}) async {
    final ResetParams resetParams = ResetParams(password: password);
    final response = await doDeleteUser.call(resetParams);
    response.fold((failure) => emit(state.copyWith(user: null)),
        (success) => emit(state.copyWith(user: null)));
  }

  Future<void> doEditProfile(
      {required String userName, required String url}) async {
    final ProfileDetailsParams profileDetailsParams = ProfileDetailsParams(
        userName: userName, photoUrl: url, phoneNumber: null);
    final response = await doEditUserProfile.call(profileDetailsParams);
    response.fold((failure) => emit(state.copyWith(user: null)),
        (user) => emit(state.copyWith(user: user)));
  }
}
