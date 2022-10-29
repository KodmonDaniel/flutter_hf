import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/api/models/city_clouds.dart';
import 'package:flutter_hf/repository/api/models/city_coord.dart';
import 'package:flutter_hf/repository/api/models/city_main.dart';
import 'package:flutter_hf/repository/api/models/city_weather.dart';
import 'package:flutter_hf/repository/api/models/city_wind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityResponse extends Equatable {
  @JsonKey(name: "coord") final CityCoord? coord;
  @JsonKey(name: "weather") final List<CityWeather>? weather;
  @JsonKey(name: "main") final CityMain? main;
  @JsonKey(name: "wind") final CityWind? wind;
  @JsonKey(name: "clouds") final CityClouds? clouds;
  @JsonKey(name: "name") final String? name;


  const CityResponse({this.coord, this.weather, this.main, this.wind, this.clouds, this.name});

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);

  @override
  List<Object?> get props => [coord, weather, main, wind, clouds, name];
}