import 'package:bsl_support/src/features/live_sport/data/repositories/live_sport_repository.dart';
import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';
import 'package:bsl_support/src/shared/utils/extensions/riverpod_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_sport_view_controller.g.dart';

@Riverpod(keepAlive: true)
class GetLiveSports extends _$GetLiveSports {
  Future<List<LiveSportModel>> _fetchData() async {
    final client = await ref.getDebouncedLiveSportHttpClient();
    final repository = ref.read(
      liveSportRemoteRepositoryProvider(client: client),
    );
    return repository.getLiveSports();
  }

  @override
  FutureOr<List<LiveSportModel>> build() {
    return _fetchData();
  }
}
