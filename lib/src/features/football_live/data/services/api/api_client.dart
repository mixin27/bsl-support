import 'package:bsl_support/src/errors/exceptions.dart';
import 'package:bsl_support/src/features/football_live/domain/football_live_model.dart';
import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

class FootballLiveApiClient {
  FootballLiveApiClient(
    Dio Function()? clientFactory,
  ) : _clientFactory = clientFactory ?? (() => Dio());

  final Dio Function() _clientFactory;

  Future<FootballLiveModel> getFootballLive() async {
    final client = _clientFactory();

    try {
      final response = await client.get('/all-match');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return FootballLiveModel.fromJson(data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } catch (e) {
      throw UnknownException();
    }
  }

  Future<FootballLiveLink> getFootballLiveLink(String id) async {
    final client = _clientFactory();

    try {
      final response = await client.get("/link/$id");
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return FootballLiveLink.fromJson(data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } catch (e) {
      throw UnknownException();
    }
  }
}

@riverpod
FootballLiveApiClient footballLiveApiClient(Ref ref, {Dio? client}) {
  return FootballLiveApiClient(
      () => client ?? ref.read(footballLiveClientProvider));
}
