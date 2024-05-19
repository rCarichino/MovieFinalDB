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
      //Creating credential for reautentication
      AuthCredential credential = EmailAuthProvider.credential(
          email: "${user?.email}", password: "${resetParams.password}");
      //Reautentication
      await user?.reauthenticateWithCredential(credential);
      //Deleting user
      await user?.delete();
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(DeleteUserFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, void>> resetParams(ResetParams resetParams) async {
    //User will be alraedy logged in
    User? user = FirebaseAuth.instance.currentUser;
    try {
      //Creating credential for reautentication
      AuthCredential credential = EmailAuthProvider.credential(
          email: "${user!.email}", password: "${resetParams.password}");
      //Reautentication
      await user.reauthenticateWithCredential(credential);
      //Sending email link for password reset
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: "${user.email}");
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(ResetEmailFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, User>> editUserProfile(
      ProfileDetailsParams profileDetailsParams) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      //Modifica userName
      profileDetailsParams.userName != ""
          ? await user?.updateDisplayName(profileDetailsParams.userName)
          : null;
      //Modifica photoUrl
      profileDetailsParams.photoUrl != ""
          ? await user?.updatePhotoURL(profileDetailsParams.photoUrl)
          : null;
      //Aspetto che vengano aggiornati i dati
      await user!.reload();
      user = FirebaseAuth.instance.currentUser;
      return Right(user!);
    } on FirebaseAuthException catch (error) {
      return Left(EditUserProfileFailure(error.code));
    }
  }
}
