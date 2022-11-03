import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(ignoreUnannotated: true)
class StoredWeather extends Equatable {
  @JsonKey(name: 'city') final String? city;
  @JsonKey(name: 'temp') final double? temp;
  @JsonKey(name: 'icon') final String? icon;
  @JsonKey(name: 'time') final DateTime? time;

  const StoredWeather({this.city, this.temp, this.icon, this.time});

  //factory CityClouds.fromJson(Map<String, dynamic> json) => _$CityCloudsFromJson(json);

   Map<String, dynamic> toJson() => {
    'city': city,
    'temp': temp,
    'icon': icon,
    'time': time
  };

  static StoredWeather fromJson(Map<String, dynamic> json) => StoredWeather(
    city: json['city'],
    temp: double.parse(json['temp'].toString()),
    icon: json['icon'],
    time: DateTime.parse(json['time'].toDate().toString())
  );

  @override
  List<Object?> get props => [city, temp, icon, time];
}