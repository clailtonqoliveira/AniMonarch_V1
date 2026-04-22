import 'package:dio/dio.dart';
import 'package:animonarch/core/constants/api_constants.dart';

class DioClient {
  DioClient._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.jikanBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  static Dio get instance => _dio;
}
