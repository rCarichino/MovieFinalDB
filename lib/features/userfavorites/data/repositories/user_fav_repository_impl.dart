import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/userfavorites/domain/entities/user_fav_ent.dart';
import 'package:moviedb/features/userfavorites/domain/repositories/user_fav_repository.dart';

class UserFavoritiesRepositoryImpl extends UserFavoritiesRepository {
  final _favmovie = FirebaseFirestore.instance
      .collection(dotenv.env["FAVMOVIE_COLLECTION_REF"]!);

  @override
  Future<Either<Failure, void>> addToStorage(UserFavEnt userFavEnt) async {
    try {
      final docRef = _favmovie.doc(userFavEnt.movieName);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final List<dynamic> userIds = docSnapshot['userIds'];
        if (!userIds.contains(userFavEnt.userIds!.first)) {
          userIds.add(userFavEnt.userIds!.first);
        }
        await docRef.update({"userIds": userIds});
      } else {
        await docRef.set(userFavEnt.toJson());
      }
      return const Right(null);
    } on FirebaseException catch (error) {
      return Left(FirestoreFailure(message: error.code));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromStorage(UserFavEnt userFavEnt) async {
    try {
      final docRef = _favmovie.doc(userFavEnt.movieName);
      final docSnapshot = await docRef.get();
      final userIds = docSnapshot['userIds'];
      userIds.remove(userFavEnt.userIds!.first);
      await docRef.update({"userIds": userIds});
      return const Right(null);
    } on FirebaseException catch (error) {
      return Left(FirestoreFailure(message: error.code));
    }
  }

  Future<Either<Failure, List<UserFavEnt>>> getFromStorage(
      UserFavEnt userFavEnt) async {
    try {
      final querySnapshot = await _favmovie
          .where('userIds', arrayContains: userFavEnt.userIds!.first)
          .get();
      final List<UserFavEnt> userFavMovie =
          querySnapshot.docs.map((data) => UserFavEnt.fromJson(data)).toList();
      return Right(userFavMovie);
    } on FirebaseException catch (error) {
      return Left(FirestoreFailure(message: error.code));
    }
  }
}
