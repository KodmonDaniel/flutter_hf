// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
      coord: json['coord'] == null
          ? null
          : CityCoord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => CityWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: json['main'] == null
          ? null
          : CityMain.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : CityWind.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : CityClouds.fromJson(json['clouds'] as Map<String, dynamic>),
      name: json['name'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'name': instance.name,
      'id': instance.id,
    };
