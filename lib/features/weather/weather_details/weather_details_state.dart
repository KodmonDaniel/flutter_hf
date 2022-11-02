import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart';

class WeatherDetailsState extends Equatable {
  final CityResponse? cityResponse;
  final bool isCelsius;
  final AssetImage background;

  const WeatherDetailsState({
    required this.cityResponse,
    required this.isCelsius,
    required this.background
  });

  @override
  List<Object?> get props => [cityResponse, isCelsius];

  WeatherDetailsState copyWith({CityResponse? cityResponse, required bool isCelsius})
  => WeatherDetailsState(
      cityResponse: cityResponse,
      isCelsius: isCelsius,
      background: background
  );
}