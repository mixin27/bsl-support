import 'package:bsl_support/src/features/football_live/domain/football_live_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/api/api_client.dart';
import 'football_live_repository_remote.dart';

part 'football_live_repository.g.dart';

abstract class FootballLiveRepository {
  Future<FootballLiveModel> getFootballLive();
  Future<FootballLiveLink> getFootballLiveLink(String id);
}

@riverpod
FootballLiveRepository footballLiveRemoteRepository(Ref ref, {Dio? client}) {
  final apiClient = ref.read(footballLiveApiClientProvider(client: client));
  return FootballLiveRepositoryRemote(apiClient: apiClient);
}
