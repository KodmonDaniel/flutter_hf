// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_coord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityCoord _$CityCoordFromJson(Map<String, dynamic> json) => CityCoord(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CityCoordToJson(CityCoord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
