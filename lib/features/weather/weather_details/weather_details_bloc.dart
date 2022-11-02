import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/api/models/city_response.dart';
import 'weather_details_state.dart';
import 'weather_details_event.dart';
import 'package:flutter_hf/repository/api/models/city_response.dart' as model;

class WeatherDetailsBloc extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {

  WeatherDetailsBloc({required model.CityResponse cityResponse, required bool isCelsius, Key? key}) : super(WeatherDetailsState(cityResponse: cityResponse, isCelsius: isCelsius, background: getBackgroundFromWeather(cityResponse)));}

  AssetImage getBackgroundFromWeather(CityResponse cityResponse) {
    late String weather;
    var id = cityResponse.weather?[0].id;

    if (id == null) {
      weather = "clear";
    } else  if (id >= 200 && id < 300) { //storm
      weather = "storm";
    } else  if (id >= 300 && id < 400) { //drizzle
      weather = "rain";
    } else  if (id >= 500 && id < 600) { //rain
      weather = "rain";
    } else  if (id >= 600 && id < 700) { //snow
      weather = "snow";
    } else  if (id >= 700 && id < 800) { //mist
      weather = "fog";
    } else  if (id == 800) { //clear
      weather = "clear";
    }  else  if (id > 800 && id < 810) { //cloud
      weather = "cloud";
    } else {
      weather = "clear";
    }

    return AssetImage("assets/images/background/${weather}_bg.png");
}