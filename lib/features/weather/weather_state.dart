import 'package:equatable/equatable.dart';
import '../../repository/api/models/city_response.dart';

class WeatherState extends Equatable {
  final List<CityResponse>? citiesWeatherList;
  final String cityIdList;
  final bool isLoading;
  final bool isCelsius;

  const WeatherState({
    this.citiesWeatherList,
    this.cityIdList = "722437,3054643",
    this.isLoading = true,
    this.isCelsius = true   //todo save secur. storage
  });

  @override
  List<Object?> get props => [citiesWeatherList, isLoading];

  WeatherState copyWith({List<CityResponse>? citiesWeatherList, bool? isLoading, bool? isCelsius})
  => WeatherState(
    citiesWeatherList: citiesWeatherList,
    isLoading: isLoading ?? this.isLoading,
    isCelsius: isCelsius ?? this.isCelsius
  );
}