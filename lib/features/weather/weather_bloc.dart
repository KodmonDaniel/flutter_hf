import 'package:bloc/bloc.dart';
import '../../repository/api/api_repository.dart';
import 'weather_state.dart';
import 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository;

  WeatherBloc(this.apiRepository) : super(const WeatherState()) {

    /// Loads weather data from repository
    on<CitiesWeatherRefreshEvent>((event, emit) async {
      await apiRepository.getWeather(state.cityIdList).then((value) =>
          emit(state.copyWith(
              citiesWeatherList: value,
              isLoading: false
      ))
      ).catchError((error) {});
    });


  }

}