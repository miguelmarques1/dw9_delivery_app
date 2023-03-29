// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dw9_delivery_app/app/core/global/global_context.dart';

import '../../exceptions/expire_token_exception.dart';
import '../custom_dio.dart';

class AuthInterceptor extends Interceptor {

  final CustomDio dio;
  AuthInterceptor({
    required this.dio,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if(err.response?.statusCode == 401) {
    try {
      if(err.requestOptions.path != '/auth/refresh') {
        await _refreshToken(err);
        await _retryRequest(err, handler);
      } else {
        GlobalContext.instance.loginExpire();
      }
    } catch (e) {
      GlobalContext.instance.loginExpire();
    }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString('refreshToken');
      if(refreshToken == null) {
        return;
      }
      final response = await dio.auth().put('/auth/refresh',
        data: {
          'refresh_token': refreshToken
        }
      );

      sp.setString('accessToken', response.data['access_token']);
      sp.setString('refreshToken', response.data['refresh_token']);
    } on DioError catch(e, s) {
      log('Erro ao realizar refresh token', error: e, stackTrace: s);
      throw ExpireTokenException();
    }
  }
  
  Future<void> _retryRequest(DioError err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final result = await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method
      ),
      queryParameters: requestOptions.queryParameters
    );
    handler.resolve(Response(requestOptions: requestOptions, data: result.data, statusCode: result.statusCode, statusMessage: result.statusMessage));
  } 
}
