import 'package:bsl_support/src/features/football_live/data/repositories/football_live_repository.dart';
import 'package:bsl_support/src/features/football_live/domain/football_live_model.dart';
import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:bsl_support/src/shared/utils/extensions/riverpod_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'football_live_controller.g.dart';

@Riverpod(keepAlive: true)
class GetAllFootballLive extends _$GetAllFootballLive {
  Future<FootballLiveModel> _fetchData() async {
    final client = await ref.getDebouncedFootballLiveHttpClient();
    final repository = ref.read(
      footballLiveRemoteRepositoryProvider(client: client),
    );
    return repository.getFootballLive();
  }

  @override
  FutureOr<FootballLiveModel> build() {
    return _fetchData();
  }
}

@riverpod
class GetFootballLiveLink extends _$GetFootballLiveLink {
  Future<FootballLiveLink> _fetchData(String id) async {
    final client = await ref.getDebouncedFootballLiveHttpClient();
    final repository = ref.read(
      footballLiveRemoteRepositoryProvider(client: client),
    );
    return repository.getFootballLiveLink(id);
  }

  @override
  FutureOr<FootballLiveLink> build(String id) {
    return _fetchData(id);
  }
}

@riverpod
class GetLinkController extends _$GetLinkController {
  @override
  void build() {
    // return ;
  }

  Future<FootballLiveLink> getLink(String id) async {
    final client = ref.read(footballLiveClientProvider);
    final repository = ref.read(
      footballLiveRemoteRepositoryProvider(client: client),
    );
    return repository.getFootballLiveLink(id);
  }
}
