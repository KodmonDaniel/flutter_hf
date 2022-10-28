import 'package:equatable/equatable.dart';
import '../../repository/api/models/city_response.dart';

class WeatherState extends Equatable {
  final List<CityResponse>? citiesWeatherList;
  final String cityIdList;
  final bool isLoading;

  const WeatherState({
    this.citiesWeatherList,
    this.cityIdList = "722437,3054643",
    this.isLoading = true
  });

  @override
  List<Object?> get props => [citiesWeatherList, isLoading];

  WeatherState copyWith({List<CityResponse>? citiesWeatherList, bool? isLoading})
  => WeatherState(
    citiesWeatherList: citiesWeatherList,
    isLoading: isLoading ?? this.isLoading
  );
}