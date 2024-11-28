import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/api/api_client.dart';
import 'live_sport_repository_remote.dart';

part 'live_sport_repository.g.dart';

abstract class LiveSportRepository {
  Future<List<LiveSportModel>> getLiveSports();
}

@riverpod
LiveSportRepository liveSportRemoteRepository(Ref ref, {Dio? client}) {
  return LiveSportRepositoryRemote(
    apiClient: ref.read(
      liveSportApiClientProvider(client: client),
    ),
  );
}
