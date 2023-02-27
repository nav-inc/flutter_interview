import 'package:flutter/foundation.dart';

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
}
