import 'package:bloc/bloc.dart';
import 'package:flutter_hf/features/history/history_event.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final FirestoreRepository firestoreRepository;

  HistoryBloc(this.firestoreRepository) : super(const HistoryState()) {

    /// Loads weather data from firestore repository
    on<HistoryRefreshEvent>((event, emit) async {

     //firestoreRepository.wasd();

      await firestoreRepository.getWeatherList().then((value) =>
          emit(state.copyWith(
            storedWeathers: value,
            isLoading: false
          ))
      ).catchError((error) {});
    });
  }
}
