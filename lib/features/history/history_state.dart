import 'package:equatable/equatable.dart';
import '../../repository/api/models/city_response.dart';

class HistoryState extends Equatable {
  final List<CityResponse>? citiesWeatherList;
  final String cityIdList;
  final bool isLoading;
  final bool isCelsius;

  const HistoryState({
    this.citiesWeatherList,
    this.cityIdList = "722437,3054643,721472,721239,3052009,3050616,3050434,717582,716935,3046526,3045643,715429,3044760,3044774,715126,3044310,3044082,3042929,3042638",
    this.isLoading = true,
    this.isCelsius = true   //todo save secur. storage
  });

  @override
  List<Object?> get props => [citiesWeatherList, isLoading];

  HistoryState copyWith({List<CityResponse>? citiesWeatherList, bool? isLoading, bool? isCelsius})
  => HistoryState(
    citiesWeatherList: citiesWeatherList,
    isLoading: isLoading ?? this.isLoading,
    isCelsius: isCelsius ?? this.isCelsius
  );
}