import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class CitiesWeatherRefreshEvent extends WeatherEvent {
  CitiesWeatherRefreshEvent();

  @override
  List<Object?> get props => [];
}
