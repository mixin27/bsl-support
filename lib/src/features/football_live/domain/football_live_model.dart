import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'football_live_model.g.dart';

@JsonSerializable(createToJson: false)
class FootballLiveModel extends Equatable {
  const FootballLiveModel({
    required this.result,
  });

  @JsonKey(name: 'result', defaultValue: [])
  final List<FootballLiveData> result;

  factory FootballLiveModel.fromJson(Map<String, dynamic> json) =>
      _$FootballLiveModelFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable(createToJson: false)
class FootballLiveData extends Equatable {
  const FootballLiveData({
    required this.league,
    required this.homeFlag,
    required this.homeName,
    required this.awayFlag,
    required this.awayName,
    required this.date,
    required this.time,
    required this.status,
    required this.score,
    required this.id,
  });

  final String league;

  @JsonKey(name: 'home_flag')
  final String homeFlag;

  @JsonKey(name: 'home_name')
  final String homeName;

  @JsonKey(name: 'away_flag')
  final String awayFlag;

  @JsonKey(name: 'away_name')
  final String awayName;

  final String date;
  final String time;
  final String status;
  final String score;
  final String id;

  factory FootballLiveData.fromJson(Map<String, dynamic> json) =>
      _$FootballLiveDataFromJson(json);

  @override
  List<Object?> get props =>
      [league, homeName, awayName, date, time, status, score, id];

  @override
  bool? get stringify => true;
}

@JsonSerializable(createToJson: false)
class FootballLiveLink extends Equatable {
  const FootballLiveLink({
    required this.url,
  });

  final String url;

  factory FootballLiveLink.fromJson(Map<String, dynamic> json) =>
      _$FootballLiveLinkFromJson(json);

  @override
  List<Object?> get props => [url];

  @override
  bool? get stringify => true;
}
