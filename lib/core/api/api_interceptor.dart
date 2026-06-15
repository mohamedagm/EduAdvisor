import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    this.language = ApiConstants.defaultLanguage,
    this.accessToken,
  });

  final String language;
  final String? accessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = language;

    if (accessToken != null && accessToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }
}
