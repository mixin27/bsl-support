import 'package:bsl_support/src/features/soco_live/data/service/api/soco_live_api_client.dart';
import 'package:bsl_support/src/features/soco_live/domain/soco_live_model.dart';
import 'package:dio/dio.dart';

import 'soco_live_repository.dart';

class SocoLiveRepositoryRemote implements SocoLiveRepository {
  SocoLiveRepositoryRemote({
    required SocoLiveApiClient apiClient,
  }) : _apiClient = apiClient;

  final SocoLiveApiClient _apiClient;

  @override
  Future<List<SocoLiveMatch>> getMatches({CancelToken? cancelToken}) async {
    return _apiClient.getMatches(cancelToken: cancelToken);
  }
}
