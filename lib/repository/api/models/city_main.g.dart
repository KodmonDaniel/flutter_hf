// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityMain _$CityMainFromJson(Map<String, dynamic> json) => CityMain(
      temp: (json['temp'] as num?)?.toDouble(),
      temp_min: (json['temp_min'] as num?)?.toDouble(),
      temp_max: (json['temp_max'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CityMainToJson(CityMain instance) => <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };
