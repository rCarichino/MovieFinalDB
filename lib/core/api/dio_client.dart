import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  final dio = Dio(BaseOptions(
    baseUrl: dotenv.env["BASE_URL"] ?? '',
  ));

  Future<Either<Failure, T>> getRequest<T>(String url,
      {required Map<String, dynamic>? queryParameters,
      required ResponseConverter<T> converter}) async {
    try {
      queryParameters!['api_key'] = dotenv.env["APPID"];
      final response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode != 200) {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
      return Right(converter(response.data));
    } on DioException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
