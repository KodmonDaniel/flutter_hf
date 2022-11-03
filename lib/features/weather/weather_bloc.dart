import 'package:bloc/bloc.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import '../../repository/api/api_repository.dart';
import 'weather_state.dart';
import 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository;
  final FirestoreRepository firestoreRepository;

  WeatherBloc(this.apiRepository, this.firestoreRepository) : super(const WeatherState()) {

    /// Loads weather data from repository
    on<CitiesWeatherRefreshEvent>((event, emit) async {
      await apiRepository.getWeather(state.cityIdList).then((value) =>
          emit(state.copyWith(
              citiesWeatherList: value,
              isLoading: false
      ))
      ).catchError((error) {});
    });

    /// Loads weather data from repository
    on<CitiesWeatherSaveEvent>((event, emit) async {
      await apiRepository.getWeather(state.cityIdList).then((value) =>
          emit(state.copyWith(
              citiesWeatherList: value,
              isLoading: false
          ))
      ).catchError((error) {});
    });


  }

}