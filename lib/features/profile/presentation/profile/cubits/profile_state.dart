part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool showPassword;

  const ProfileState({required this.showPassword, required this.user});

  factory ProfileState.initial() {
    return ProfileState(
        user: FirebaseAuth.instance.currentUser, showPassword: true);
  }

  ProfileState copyWith({User? user, bool? showPassword}) =>
      ProfileState(user: user ?? this.user , showPassword: showPassword ?? this.showPassword);

  @override
  List<Object?> get props => [user, showPassword];
}
