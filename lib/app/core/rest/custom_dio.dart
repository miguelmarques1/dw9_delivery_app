import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dw9_delivery_app/app/core/rest/interceptors/auth_interceptor.dart';

import '../config/env/env.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;
  CustomDio() : super(BaseOptions(
    baseUrl: Env.i['backend_base_url'] ?? '',
    connectTimeout: 5000,
    receiveTimeout: 60000,
    contentType: 'application/json',
  )){
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true
    ));
    _authInterceptor = AuthInterceptor(dio: this);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}