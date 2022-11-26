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
  final bool isCelsius;
  CitiesWeatherChangeUnitEvent(this.isCelsius);

  @override
  List<Object?> get props => [];
}
/*
class CitiesWeatherUserDetailsChangeEvent extends WeatherEvent {
  final String email;
  CitiesWeatherUserDetailsChangeEvent(this.email);

  @override
  List<Object?> get props => [];
}*/
