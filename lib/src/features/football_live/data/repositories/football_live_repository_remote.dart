import 'package:bsl_support/src/features/football_live/domain/football_live_model.dart';

import '../services/api/api_client.dart';
import 'football_live_repository.dart';

/// Remote data source for [FootballLiveModel].
class FootballLiveRepositoryRemote implements FootballLiveRepository {
  FootballLiveRepositoryRemote({
    required FootballLiveApiClient apiClient,
  }) : _apiClient = apiClient;

  final FootballLiveApiClient _apiClient;

  final Map<String, FootballLiveLink> _cachedData = {};

  @override
  Future<FootballLiveModel> getFootballLive() async {
    return _apiClient.getFootballLive();
  }

  /// Implements basic local caching.
  /// See: https://docs.flutter.dev/get-started/fwe/local-caching
  @override
  Future<FootballLiveLink> getFootballLiveLink(String id) async {
    if (!_cachedData.containsKey(id)) {
      // No cached data, request activities
      final result = await _apiClient.getFootballLiveLink(id);
      _cachedData[id] = result;
      return result;
    } else {
      // Return cached data if available
      return _cachedData[id]!;
    }
  }
}
