import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/api/models/city_coord.dart';
import 'package:flutter_hf/repository/api/models/city_weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityResponse extends Equatable {
  @JsonKey(name: "coord") final CityCoord? coord;
  @JsonKey(name: "weather") final List<CityWeather>? weather;
  @JsonKey(name: "name") final String? name;


  const CityResponse({this.coord, this.weather, this.name});

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);

  @override
  List<Object?> get props => [coord, weather, name];
}