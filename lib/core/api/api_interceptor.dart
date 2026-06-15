import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({this.language = ApiConstants.defaultLanguage});

  final String language;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = language;

    super.onRequest(options, handler);
  }
}
