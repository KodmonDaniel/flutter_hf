import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_coord.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityCoord extends Equatable {
  @JsonKey(name: "lon") final double? lon;
  @JsonKey(name: "lat") final double? lat;

  const CityCoord({this.lon, this.lat});

  factory CityCoord.fromJson(Map<String, dynamic> json) => _$CityCoordFromJson(json);

  @override
  List<Object?> get props => [lon, lat];
}