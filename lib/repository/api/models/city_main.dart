import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_main.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CityMain extends Equatable {
  @JsonKey(name: "temp") final double? temp;
  @JsonKey(name: "temp_min") final double? temp_min;
  @JsonKey(name: "temp_max") final double? temp_max;
  @JsonKey(name: "pressure") final double? pressure;
  @JsonKey(name: "humidity") final double? humidity;

  const CityMain({this.temp, this.temp_min, this.temp_max, this.pressure, this.humidity});

  factory CityMain.fromJson(Map<String, dynamic> json) => _$CityMainFromJson(json);

  @override
  List<Object?> get props => [temp, temp_min, temp_max, pressure, humidity];
}