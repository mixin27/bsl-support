import 'dart:io';

import 'package:bsl_support/src/config/env.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final rapidApiKey = Env.rapidApiKey;

    if (rapidApiKey.isNotEmpty) {
      if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
        options.headers["X-RapidAPI-Key"] = rapidApiKey;
      }
    }

    return handler.next(options);
  }
}
