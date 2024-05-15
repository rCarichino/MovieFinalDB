import 'package:dartz/dartz.dart';

import 'package:moviedb/core/error/failure.dart';

import 'package:moviedb/features/auth/domain/entities/login.dart';

import 'package:moviedb/features/auth/domain/entities/register.dart';

import 'package:moviedb/features/auth/domain/entities/auth_params.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasources.dart';

class AuthRepositoryImpl extends AuthRepository{

  final AuthRemoteDataSources authRemoteDataSources;

  AuthRepositoryImpl(this.authRemoteDataSources);

  @override
  Future<Either<Failure, Login>> login(AuthParams authParams) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Register>> register(AuthParams authParams) {
    // TODO: implement register
    throw UnimplementedError();
  }


}