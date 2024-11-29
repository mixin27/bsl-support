import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_tv_model.g.dart';

@JsonSerializable(createToJson: false)
class LiveTvModel extends Equatable {
  const LiveTvModel({required this.title, required this.url});

  final String title;
  final String url;

  factory LiveTvModel.fromJson(Map<String, dynamic> json) =>
      _$LiveTvModelFromJson(json);

  @override
  List<Object?> get props => [title, url];

  @override
  bool? get stringify => true;
}
