import 'package:bsl_support/src/features/live_tv/data/services/live_tvs_service.dart';
import 'package:bsl_support/src/features/live_tv/domain/live_tv_model.dart';

import 'live_tvs_repository.dart';

class LiveTvsRepositoryLocal implements LiveTvsRepository {
  LiveTvsRepositoryLocal(this._service);

  final LiveTvsService _service;

  @override
  Future<List<LiveTvModel>> getAllLiveTvs() async {
    return await _service.getAllLiveTvs();
  }
}
