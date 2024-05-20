import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/profile/domain/repositories/profile_repository.dart';

import '../../domain/entities/profile_details_params.dart';
import '../../domain/entities/reset_params.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl();

  @override
  Future<Either<Failure, void>> deleteUser(ResetParams resetParams) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      AuthCredential credential = EmailAuthProvider.credential(
          email: "${user?.email}", password: "${resetParams.password}");
      await user?.reauthenticateWithCredential(credential);
      await user?.delete();
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(DeleteUserFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, User>> resetParams(ResetParams resetParams) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!, password: resetParams.password!);
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(resetParams.newPassword!);

      return Right(FirebaseAuth.instance.currentUser!);
    } on FirebaseAuthException catch (error) {
      return Left(ResetEmailFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, User>> editUserProfile(
      ProfileDetailsParams profileDetailsParams) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      profileDetailsParams.userName != ""
          ? await user?.updateDisplayName(profileDetailsParams.userName)
          : null;
      profileDetailsParams.photoUrl != ""
          ? await user?.updatePhotoURL(profileDetailsParams.photoUrl)
          : null;
      await user!.reload();
      user = FirebaseAuth.instance.currentUser;
      return Right(user!);
    } on FirebaseAuthException catch (error) {
      return Left(EditUserProfileFailure(error.code));
    }
  }
}
