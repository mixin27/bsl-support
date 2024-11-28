import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_sport_model.g.dart';

@JsonSerializable(createToJson: false)
class LiveSportModel extends Equatable {
  const LiveSportModel({
    required this.data,
    required this.sportId,
    required this.sportName,
  });

  @JsonKey(defaultValue: [])
  final List<LiveSportData> data;

  @JsonKey(name: 'sport_id', defaultValue: 0)
  final int sportId;

  @JsonKey(name: 'sport_name', defaultValue: '')
  final String sportName;

  factory LiveSportModel.fromJson(Map<String, dynamic> json) =>
      _$LiveSportModelFromJson(json);

  @override
  List<Object?> get props => [sportId, sportName];

  @override
  bool? get stringify => true;
}

@JsonSerializable(createToJson: false)
class LiveSportData extends Equatable {
  const LiveSportData({
    required this.score,
    required this.iframeSource,
    required this.m3u8Source,
    required this.startTime,
    required this.teamOne,
    required this.teamTwo,
  });

  @JsonKey(name: 'score')
  final String score;

  @JsonKey(name: 'iframe_source')
  final String iframeSource;

  @JsonKey(name: 'm3u8_source')
  final String m3u8Source;

  // 2024-11-26T20:00:00
  @JsonKey(name: 'start_time')
  final String startTime;

  @JsonKey(name: 'team_one_name')
  final String teamOne;

  @JsonKey(name: 'team_two_name')
  final String teamTwo;

  factory LiveSportData.fromJson(Map<String, dynamic> json) =>
      _$LiveSportDataFromJson(json);

  @override
  List<Object?> get props => [score, startTime, teamOne, teamTwo];

  @override
  bool? get stringify => true;
}
