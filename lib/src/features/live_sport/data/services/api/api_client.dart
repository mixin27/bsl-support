import 'package:bsl_support/src/errors/exceptions.dart';
import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';
import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

class LiveSportApiClient {
  LiveSportApiClient(
    Dio Function()? clientFactory,
  ) : _clientFactory = clientFactory ?? (() => Dio());

  final Dio Function() _clientFactory;

  Future<List<LiveSportModel>> getLiveSports() async {
    final client = _clientFactory();

    try {
      final response = await client.get('/api/v2/all-live-stream');

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map((e) => LiveSportModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(response.statusMessage);
      }
    } catch (e) {
      throw UnknownException();
    }
  }
}

@riverpod
LiveSportApiClient liveSportApiClient(Ref ref, {Dio? client}) {
  return LiveSportApiClient(() => client ?? ref.read(liveSportClientProvider));
}
