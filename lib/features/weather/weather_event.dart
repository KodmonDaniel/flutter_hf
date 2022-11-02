import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart';

abstract class WeatherEvent extends Equatable {}

class CitiesWeatherRefreshEvent extends WeatherEvent {
  CitiesWeatherRefreshEvent();

  @override
  List<Object?> get props => [];
}

class CitiesWeatherSaveEvent extends WeatherEvent {
  CitiesWeatherSaveEvent();

  @override
  List<Object?> get props => [];
}
