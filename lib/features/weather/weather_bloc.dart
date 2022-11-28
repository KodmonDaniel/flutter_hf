import 'package:bloc/bloc.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import '../../preferences/secure_storage.dart';
import '../../repository/api/api_repository.dart';
import 'weather_state.dart';
import 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository;
  final FirestoreRepository firestoreRepository;

  WeatherBloc(this.apiRepository, this.firestoreRepository) : super(const WeatherState()) {

    /// Loads weather data from repository
    on<CitiesWeatherRefreshEvent>((event, emit) async {
      bool tempUnit = await getStoredTempUnit();
      await apiRepository.getWeather(state.cityIdList).then((value) =>
          emit(state.copyWith(
              citiesWeatherList: value,
              isLoading: false,
              isCelsius: tempUnit
          ))
      ).catchError((error) {});
    });

    /// Saves to firestore
    on<CitiesWeatherSaveEvent>((event, emit) async {
      await firestoreRepository.saveWeather(state.citiesWeatherList ?? [])
          .catchError((error) {});
    });

    /// Refresh the temp unit from secure storage
    on<CitiesWeatherChangeUnitEvent>((event, emit) {
      emit(state.copyWith(
          isCelsius: event.isCelsius
      ));
    });


  }



  /// Gets the temp unit from secure storage
  Future<bool> getStoredTempUnit() async {
    var value = await SecureStorage.instance.get("tempUnit");
    if (value == "false") {
      return false;
    } else {
      return true;
    }
  }

}