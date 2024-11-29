import 'package:bsl_support/src/features/live_tv/data/services/live_tvs_service.dart';
import 'package:bsl_support/src/features/live_tv/domain/live_tv_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'live_tvs_repository_local.dart';

part 'live_tvs_repository.g.dart';

abstract class LiveTvsRepository {
  Future<List<LiveTvModel>> getAllLiveTvs();
}

@riverpod
LiveTvsRepository liveTvsRepository(Ref ref) {
  return LiveTvsRepositoryLocal(LiveTvsService());
}
