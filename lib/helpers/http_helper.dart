import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_provider/helpers/failure.dart';

class HttpHelper {
  final baseUrl = "https://localhost:8080";
  static Dio? dio;

  String getUrl(String path) {
    return "$baseUrl$path";
  }

  Future<Either<Failure, dynamic>> sendGet(String path) async {
    String url = getUrl(path);
    Response<dynamic>? response = await dio?.get(url);
    return _parseResponse(response);
  }

  Future<Either<Failure, dynamic>> sendPost(String path, dynamic data) async {
    String url = getUrl(path);
    Response<dynamic>? response = await dio?.post(url, data: data);
    print(_parseResponse(response));
    return _parseResponse(response);
  }

  _parseResponse(Response<dynamic>? response) {
    if (response == null) {
      return const Left(Failure(code: 500));
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.statusCode == 401) {
        // Logout
      }
      String? errorMessage;
      if (response.statusMessage?.isEmpty ?? true) {
        errorMessage = response.data['error'];
      } else {
        errorMessage = response.statusMessage;
      }
      return Left(
        Failure(
          code: response.statusCode,
          message: errorMessage,
        ),
      );
    }
    return Right(response.data);
  }

}
