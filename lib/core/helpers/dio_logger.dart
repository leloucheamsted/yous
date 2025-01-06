import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:youscribe_logger/youscribe_logger.dart';

class DioLogger extends Interceptor with Debuggable, Loggable {
  DioLogger() : super();

  @override
  String get debugName => 'API';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      // Do not log in production
      return super.onRequest(options, handler);
    }
    logger.debug('Request: ${options.method} ${options.uri}');
    if (options.data != null) {
      logger.debug('Data: ${options.data}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) {
      // Do not log in production
      return super.onResponse(response, handler);
    }
    logger.debug(
        'Response: ${response.statusCode} ${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error('Error: ${err.message}');

    super.onError(err, handler);
  }
}
