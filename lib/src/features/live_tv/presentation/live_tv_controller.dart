import 'package:bsl_support/src/features/live_tv/data/repositories/live_tvs_repository.dart';
import 'package:bsl_support/src/features/live_tv/domain/live_tv_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_tv_controller.g.dart';

@riverpod
class GetAllLiveTvs extends _$GetAllLiveTvs {
  Future<List<LiveTvModel>> _fetchData() async {
    final repository = ref.read(liveTvsRepositoryProvider);
    return repository.getAllLiveTvs();
  }

  @override
  FutureOr<List<LiveTvModel>> build() {
    return _fetchData();
  }
}
