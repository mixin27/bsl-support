import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';

import '../services/api/api_client.dart';
import 'live_sport_repository.dart';

/// Remote data source for [LiveSportModel].
class LiveSportRepositoryRemote implements LiveSportRepository {
  LiveSportRepositoryRemote({
    required LiveSportApiClient apiClient,
  }) : _apiClient = apiClient;

  final LiveSportApiClient _apiClient;

  @override
  Future<List<LiveSportModel>> getLiveSports() async {
    return _apiClient.getLiveSports();
  }
}
