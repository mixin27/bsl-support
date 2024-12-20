import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FOOTBALL_LIVE_API_URL', obfuscate: true)
  static final String footballLiveApiUrl = _Env.footballLiveApiUrl;

  @EnviedField(varName: 'FOOTBALL_LIVE_RAPID_HOST', obfuscate: true)
  static final String footballLiveRapidHost = _Env.footballLiveRapidHost;

  @EnviedField(varName: 'LIVE_SPORT_API_URL', obfuscate: true)
  static final String liveSportApiUrl = _Env.liveSportApiUrl;
  @EnviedField(varName: 'LIVE_SPORT_RAPID_HOST', obfuscate: true)
  static final String liveSportRapidHost = _Env.liveSportRapidHost;

  @EnviedField(varName: 'RAPID_API_KEY', obfuscate: true)
  static final String rapidApiKey = _Env.rapidApiKey;

  @EnviedField(varName: 'BSL_API', obfuscate: true)
  static final String bslApi = _Env.bslApi;
}
