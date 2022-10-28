import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_weather.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityWeather extends Equatable {
  @JsonKey(name: "id") final int? id;
  @JsonKey(name: "main") final String? main;
  @JsonKey(name: "description") final String? description;
  @JsonKey(name: "icon") final String? icon;

  const CityWeather({this.id, this.main, this.description, this.icon});

  factory CityWeather.fromJson(Map<String, dynamic> json) => _$CityWeatherFromJson(json);

  @override
  List<Object?> get props => [id, main, description, icon];
}