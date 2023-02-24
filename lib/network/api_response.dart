import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthenticationResponse<T> {
  AuthenticationResponse.success(Response<T> response) {
    code = response.statusCode ?? 0;
    body = response.data ?? '' as T?;
    successful = true;
  }

  AuthenticationResponse.failure(DioError e) {
    successful = false;
    error = e;
    debugPrint('Error ${e.toString()}');
  }
  int? code;
  T? body;
  bool successful = false;
  DioError? error;
}

class ApiResponse<T> {
  ApiResponse.success(T b) {
    successful = true;
    body = b;
    error = null;
  }

  ApiResponse.failure(dynamic e) {
    successful = false;
    error = e;
    debugPrint('Error ${e?.toString()}');
  }

  ApiResponse.failureWithBody(T b, dynamic e) {
    body = b;
    successful = false;
    error = e;
    debugPrint('Error ${e?.toString()}');
  }
  late T body;
  dynamic error;
  bool successful = false;

  String unwrapFirstErrorMessage() {
//    if(error is DioError) {
//      (error as DioError).response?.data
//    }

    return '';
  }
}
