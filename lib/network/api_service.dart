import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef OnError = void Function(
  dynamic error, {
  String? info,
  bool? sendErrorInfo,
});

class ApiService {
  factory ApiService() => _instance ??= ApiService._();
  ApiService._();

  static ApiService? _instance;

  final String baseAPI = "https://pokeapi.co/api/v2";

  static const _timeout = 30;

  OnError? errorCallback;

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: baseAPI,
      connectTimeout: Duration(seconds: _timeout),
      receiveTimeout: Duration(seconds: _timeout),
    );

    final dio = Dio(options);

    return dio;
  }

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return _dio().post<T>(path, data: data);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return _dio().get<T>(path);
  }

  void notifyError(dynamic error, {String? info, bool sendErrorInfo = false}) {
    if (errorCallback != null) {
      if (error is DioException) {
        errorCallback!(
          error.error,
          info: error.toString(),
          sendErrorInfo: sendErrorInfo,
        );
      } else {
        errorCallback!(error, info: info, sendErrorInfo: sendErrorInfo);
      }
    } else {
      debugPrint('Api - Error callback not attached');
    }
  }
}
