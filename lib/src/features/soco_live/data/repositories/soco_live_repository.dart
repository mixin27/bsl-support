import 'package:bsl_support/src/features/soco_live/data/repositories/soco_live_repository_remote.dart';
import 'package:bsl_support/src/features/soco_live/data/service/api/soco_live_api_client.dart';
import 'package:bsl_support/src/features/soco_live/domain/soco_live_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'soco_live_repository.g.dart';

abstract class SocoLiveRepository {
  Future<List<SocoLiveMatch>> getMatches({CancelToken? cancelToken});
}

@riverpod
SocoLiveRepository socoLiveRemoteRepository(Ref ref, {Dio? client}) {
  return SocoLiveRepositoryRemote(
    apiClient: ref.read(socoliveApiClientProvider(client: client)),
  );
}
