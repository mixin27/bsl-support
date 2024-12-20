import 'package:bsl_support/src/errors/exceptions.dart';
import 'package:bsl_support/src/features/soco_live/domain/soco_live_model.dart';
import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'soco_live_api_client.g.dart';

class SocoLiveApiClient {
  SocoLiveApiClient(
    Dio Function()? clientFactory,
  ) : _clientFactory = clientFactory ?? (() => Dio());

  final Dio Function() _clientFactory;

  Future<List<SocoLiveMatch>> getMatches({CancelToken? cancelToken}) async {
    final client = _clientFactory();

    try {
      final response = await client.get('/matches', cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final result =
            SocoLiveModel.fromJson(response.data as Map<String, dynamic>);
        return result.data;
      } else {
        throw ServerException(response.statusMessage);
      }
    } catch (e) {
      throw UnknownException();
    }
  }
}

@riverpod
SocoLiveApiClient socoliveApiClient(Ref ref, {Dio? client}) {
  return SocoLiveApiClient(() => client ?? ref.read(socoLiveClientProvider));
}
