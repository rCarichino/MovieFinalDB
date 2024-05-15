import 'package:dartz/dartz.dart';

import '../../../../core/api/dio_client.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_params.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';

abstract class AuthRemoteDataSources {
  Future<Either<Failure, RegisterResponse>> register(AuthParams authParams);

  Future<Either<Failure, LoginResponse>> login(AuthParams authParams);
}

class AuthRemoteDataSuorcesImpl extends AuthRemoteDataSources {
  final DioClient _client;

  AuthRemoteDataSuorcesImpl(this._client);

  @override
  Future<Either<Failure, LoginResponse>> login(AuthParams authParams) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(AuthParams authParams) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
