part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;

  const ProfileState({required this.user});

  factory ProfileState.initial() {
    return const ProfileState(user: null);
  }

  @override
  List<Object?> get props => [user];

  ProfileState copyWith({required User? user}) {
    return ProfileState(user: user ?? this.user);
  }
}
