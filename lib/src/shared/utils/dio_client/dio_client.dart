import 'package:bsl_support/src/config/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_interceptor.dart';
import 'football_live_interceptor.dart';
import 'live_sport_interceptor.dart';

part 'dio_client.g.dart';

@riverpod
Dio footballLiveApiClient(Ref ref) {
  final baseUrl = Env.footballLiveApiUrl;
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
    )
    ..interceptors.addAll([
      if (!kReleaseMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      AuthInterceptor(),
      FootballLiveInterceptor(),
    ]);
  return dio;
}

@riverpod
Dio liveSportApiClient(Ref ref) {
  final baseUrl = Env.liveSportApiUrl;
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
    )
    ..interceptors.addAll([
      if (!kReleaseMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      AuthInterceptor(),
      LiveSportInterceptor(),
    ]);
  return dio;
}
