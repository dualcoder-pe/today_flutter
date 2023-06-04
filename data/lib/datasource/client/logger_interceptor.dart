import 'package:common/utils/logger.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger("[Dio][Err] ${err}");
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger("[Dio][Req] ${options.log}");
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger("[Dio][Res] ${response.log}");

    handler.next(response);
  }
}

extension RequestOptionsExt on RequestOptions {
  String get log => "$uri // $headers // $method // $path // $queryParameters // $data";
}

extension ResponseExt<T> on Response<T> {
  String get log => "$realUri // $headers // $statusMessage // $data";
}
