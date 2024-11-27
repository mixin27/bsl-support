import 'dart:io';

import 'package:bsl_support/src/config/env.dart';
import 'package:dio/dio.dart';

class FootballLiveInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiHost = Env.footballLiveRapidHost;

    if (apiHost.isNotEmpty) {
      if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
        // todo(me): change header key
        options.headers["x-auth-host"] = apiHost;
      }
    }

    return handler.next(options);
  }
}
