import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/api/api_interceptor.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({Dio? dio, ApiInterceptor? apiInterceptor})
    : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: const {'Accept': 'application/json'},
    );

    _dio.interceptors.add(apiInterceptor ?? ApiInterceptor());
  }

  final Dio _dio;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: _buildOptions(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    final response = await _dio.post(
      path,
      data: _prepareData(data: data, isFormData: isFormData),
      queryParameters: queryParameters,
      options: _buildOptions(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    final response = await _dio.put(
      path,
      data: _prepareData(data: data, isFormData: isFormData),
      queryParameters: queryParameters,
      options: _buildOptions(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    final response = await _dio.patch(
      path,
      data: _prepareData(data: data, isFormData: isFormData),
      queryParameters: queryParameters,
      options: _buildOptions(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    final response = await _dio.delete(
      path,
      data: _prepareData(data: data, isFormData: isFormData),
      queryParameters: queryParameters,
      options: _buildOptions(headers: headers),
    );
    return response.data;
  }

  Options _buildOptions({Map<String, dynamic>? headers}) {
    return Options(headers: headers);
  }

  Object? _prepareData({Object? data, required bool isFormData}) {
    return isFormData && data is Map<String, dynamic>
        ? FormData.fromMap(data)
        : data;
  }
}
