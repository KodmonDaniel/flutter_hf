import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_clouds.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityClouds extends Equatable {
  @JsonKey(name: "all") final double? all;

  const CityClouds({this.all});

  factory CityClouds.fromJson(Map<String, dynamic> json) => _$CityCloudsFromJson(json);

  @override
  List<Object?> get props => [all];
}