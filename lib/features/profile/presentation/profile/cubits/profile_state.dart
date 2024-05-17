part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;

  const ProfileState({required this.user});

  factory ProfileState.initial() {
    return ProfileState(user: FirebaseAuth.instance.currentUser);
  }

  @override
  List<Object?> get props => [user];

  ProfileState copyWith({required User? user}) {
    return ProfileState(user: user);
  }
}
