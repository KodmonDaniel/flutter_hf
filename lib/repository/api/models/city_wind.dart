import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_wind.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityWind extends Equatable {
  @JsonKey(name: "speed") final double? speed;

  const CityWind({this.speed});

  factory CityWind.fromJson(Map<String, dynamic> json) => _$CityWindFromJson(json);

  @override
  List<Object?> get props => [speed];
}