import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension DebounceAndCancelExtension on Ref {
  /// Wait for [duration] (defaults to 500ms), and then return a [Dio]
  /// which can be used to make a request.
  ///
  /// That client will automatically be closed when the provider is disposed.
  Future<Dio> getDebouncedFootballLiveHttpClient([Duration? duration]) async {
    // First, we handle debouncing.
    var didDispose = false;
    onDispose(() => didDispose = true);

    // We delay the request by 500ms, to wait for the user to stop refreshing.
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 500));

    // If the provider was disposed during the delay, it means that the user
    // refreshed again. We throw an exception to cancel the request.
    // It is safe to use an exception here, as it will be caught by Riverpod.
    if (didDispose) {
      throw Exception('Cancelled');
    }

    // We now create the client and close it when the provider is disposed.
    final client = read(footballLiveClientProvider);
    onDispose(client.close);

    // Finally, we return the client to allow our provider to make the request.
    return client;
  }

  Future<Dio> getDebouncedLiveSportHttpClient([Duration? duration]) async {
    // First, we handle debouncing.
    var didDispose = false;
    onDispose(() => didDispose = true);

    // We delay the request by 500ms, to wait for the user to stop refreshing.
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 500));

    // If the provider was disposed during the delay, it means that the user
    // refreshed again. We throw an exception to cancel the request.
    // It is safe to use an exception here, as it will be caught by Riverpod.
    if (didDispose) {
      throw Exception('Cancelled');
    }

    // We now create the client and close it when the provider is disposed.
    final client = read(liveSportClientProvider);
    onDispose(client.close);

    // Finally, we return the client to allow our provider to make the request.
    return client;
  }
}
