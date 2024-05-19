part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;

  const ProfileState({required this.user});

  factory ProfileState.initial() {
    return ProfileState(user: FirebaseAuth.instance.currentUser);
  }

  ProfileState copyWith({required User? user}) => ProfileState(user: user);

  @override
  List<Object?> get props => [user];
}
