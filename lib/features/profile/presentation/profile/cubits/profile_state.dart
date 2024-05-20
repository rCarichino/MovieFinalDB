part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool showCurrentPassword;
  final bool showNewPassword;

  const ProfileState(
      {required this.showCurrentPassword,
      required this.showNewPassword,
      required this.user});

  factory ProfileState.initial() {
    return ProfileState(
        user: FirebaseAuth.instance.currentUser,
        showCurrentPassword: true,
        showNewPassword: true);
  }

  ProfileState copyWith(
          {required User? user,
          bool? showCurrentPassword,
          bool? showNewPassword}) =>
      ProfileState(
          user: user,
          showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
          showNewPassword: showNewPassword ?? this.showNewPassword);

  @override
  List<Object?> get props => [user, showCurrentPassword,showNewPassword];
}
