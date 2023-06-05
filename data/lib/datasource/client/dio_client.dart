import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpClient {
  final Dio _dio;

  HttpClient(this._dio);

  static HttpClientBuilder Builder = HttpClientBuilder();

  Dio get dio => _dio;
}

class HttpClientBuilder {

  final Interceptors interceptors = Interceptors();

  HttpClientBuilder setInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
    return this;
  }

  HttpClient build() {
    final dio = Dio(BaseOptions(baseUrl: "https://dualcoder.pe.kr/api/"));
    interceptors.add(CookieManager(CookieJar()));
    dio.interceptors.addAll(interceptors);
    return HttpClient(dio);
  }

}