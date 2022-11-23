import 'package:equatable/equatable.dart';
import '../../repository/api/models/city_response.dart';

class WeatherState extends Equatable {
  final List<CityResponse>? citiesWeatherList;
  final String cityIdList;
  final bool isLoading;
  final bool isCelsius;

  const WeatherState({
    this.citiesWeatherList,
    this.cityIdList = "722437,3054643,721472,721239,3052009,3050616,3050434,717582,716935,3046526,3045643,715429,3044760,3044774,715126,3044310,3044082,3042929,3042638",
    this.isLoading = true,
    this.isCelsius = true // default value, overridden by secure storage at init.
  });

  @override
  List<Object?> get props => [citiesWeatherList, isLoading, isCelsius];

  WeatherState copyWith({List<CityResponse>? citiesWeatherList, bool? isLoading, bool? isCelsius})
  => WeatherState(
    citiesWeatherList: citiesWeatherList ?? this.citiesWeatherList,
    isLoading: isLoading ?? this.isLoading,
    isCelsius: isCelsius ?? this.isCelsius
  );
}