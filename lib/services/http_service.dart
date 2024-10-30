import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:pgnpartner_mobile/config/env.dart';
import 'package:pgnpartner_mobile/core/interceptors/auth_interceptor.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class HttpService {
  late Dio _dio;
  late String _authToken;
  final EnvConfig _envConfig = EnvConfig.instance;

  String get authToken => _authToken;

  HttpService({String? baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? _envConfig.server,
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));

    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(AuthInterceptor(AuthService()));
  }

  void setToken({required String token}) {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _authToken = "Bearer $token";
  }

  void removeToken() {
    _dio.options.headers['Authorization'] = null;
  }

  void setContentTypeImage() {
    _dio.options.headers['Content-Type'] = "image/jpeg";
  }

  void setContentTypeJson() {
    _dio.options.headers['Content-Type'] = "application/json";
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, dynamic data, {dynamic xVarData}) async {
    try {
      final token = await AuthService().getSessionKey();
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: (xVarData != null)
              ? {
                  'Authorization': 'Bearer $token', // Add the Bearer token here
                  'Content-Type': 'application/json', // Set Content-Type to application/json
                  'X-Var': jsonEncode(xVarData)
                }
              : {
                  'Authorization': 'Bearer $token', // Add the Bearer token here
                  'Content-Type': 'application/json', // Set Content-Type to application/json
                },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  _handleError(DioException e) {
    // Other error handling
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        while (getx.Get.isDialogOpen == true) {
          getx.Get.back();
        }
        GeneralSnackbar.show(message: "Connection timed out. Please try again.");
        throw TimeoutException(e.message ?? 'Timeout error occurred');
      case DioExceptionType.badResponse:
        throw ServerException(e.message ?? 'Server error occurred');
      case DioExceptionType.cancel:
        throw RequestCancelledException(e.message ?? 'Request was cancelled');
      case DioExceptionType.badCertificate:
        throw CertificateException(e.message ?? 'Certificate error occurred');
      case DioExceptionType.unknown:
        throw UnknownException(e.message ?? 'An unknown error occurred');
      default:
        throw UnknownException('An unexpected error occurred');
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}

class CertificateException implements Exception {
  final String message;
  CertificateException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}
