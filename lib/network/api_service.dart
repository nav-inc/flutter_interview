import 'dart:io';

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
  static const String authApiKey = 'X-API-Key';
  static const String authorization = 'authorization';
  static const String v3ApiKeyHeaderKey2 = 'X-API-Key';
  static const String acceptKey = 'Accept';
  static const String contentTypeKey = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String entJwtKey = 'X-Ent-JWT';
  static const String jwtKey = 'X-Authentication-JWT';
  static const String cookieEnd = ';';
  static const String cookie = 'Cookie';
  static const String setCookie = 'Set-Cookie';

  static ApiService? _instance;

  final String baseAPI = "https://pokeapi.co/api/v2";

  bool get isInDebugMode {
    var inDebugMode = false;
    assert(inDebugMode = true, 'set inDebugMode to true');
    return inDebugMode;
  }

  static const _timeout = 30000;

  Interceptor? aliceInterceptor;
  OnError? errorCallback;

  static Map<String, String> _defaultHeaders() => {
        acceptKey: applicationJson,
        contentTypeKey: applicationJson,
      };

  static String platformName() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isFuchsia) return 'Fuchsia';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isMacOS) return 'MacOS';
    if (Platform.isWindows) return 'Windows';
    return 'Web';
  }

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: baseAPI,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: {..._defaultHeaders()},
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
      if (error is DioError) {
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
