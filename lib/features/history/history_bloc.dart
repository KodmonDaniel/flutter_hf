import 'package:bloc/bloc.dart';
import 'package:flutter_hf/features/history/history_event.dart';
import '../../repository/api/api_repository.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final ApiRepository apiRepository;

  HistoryBloc(this.apiRepository) : super(const HistoryState()) {

    /// Loads weather data from repository
    on<HistoryRefreshEvent>((event, emit) async {
      await apiRepository.getWeather(state.cityIdList).then((value) =>
          emit(state.copyWith(
              citiesWeatherList: value,
              isLoading: false
      ))
      ).catchError((error) {});
    });


  }

}