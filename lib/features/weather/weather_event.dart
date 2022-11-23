import 'package:equatable/equatable.dart';

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

class CitiesWeatherChangeUnitEvent extends WeatherEvent {
  CitiesWeatherChangeUnitEvent();

  @override
  List<Object?> get props => [];
}
