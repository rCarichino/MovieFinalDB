import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:moviedb/core/error/failure.dart';

import 'package:moviedb/features/auth/domain/entities/auth_params.dart';
import 'package:moviedb/utils/validator.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasources.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSources authRemoteDataSources;

  AuthRepositoryImpl(this.authRemoteDataSources);

  @override
  Future<Either<Failure, User>> login(AuthParams authParams) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: authParams.email!, password: authParams.password!);
    final user = userCredential.user;
    return Right(user!);
  }

  @override
  Future<Either<Failure, UserCredential>> register(
      AuthParams authParams) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: authParams.email!, password: authParams.password!);
    return Right(userCredential);
  }
}
