import 'package:bsl_support/src/features/soco_live/data/repositories/soco_live_repository.dart';
import 'package:bsl_support/src/features/soco_live/domain/soco_live_model.dart';
import 'package:bsl_support/src/shared/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'soco_live_controller.g.dart';

@riverpod
class GetSocoLiveMatches extends _$GetSocoLiveMatches {
  Future<List<SocoLiveMatch>> _fetchData() async {
    final cancelToken = CancelToken();
    final client = ref.read(socoLiveClientProvider);
    final repository =
        ref.read(socoLiveRemoteRepositoryProvider(client: client));

    ref.onDispose(() {
      cancelToken.cancel();
    });

    return repository.getMatches(cancelToken: cancelToken);
  }

  @override
  FutureOr<List<SocoLiveMatch>> build() {
    return _fetchData();
  }
}
