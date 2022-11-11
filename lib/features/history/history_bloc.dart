import 'package:bloc/bloc.dart';
import 'package:flutter_hf/features/history/history_event.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import '../../preferences/secure_storage.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final FirestoreRepository firestoreRepository;

  HistoryBloc(this.firestoreRepository) : super(const HistoryState()) {

    /// Loads weather data from firestore repository
    on<HistoryRefreshEvent>((event, emit) async {
      bool tempUnit = await getStoredTempUnit();
      await firestoreRepository.getWeatherList().then((value) =>
          emit(state.copyWith(
            storedWeathers: value,
            isLoading: false,
            isCelsius: tempUnit
          ))
      ).catchError((error) {});
    });

    on<HistoryChangeSortCategoryEvent>((event, emit) async {
      emit(state.copyWith(
        sortByTime: !state.sortByTime,
      ));
    });

    on<HistoryChangeOrderCategoryEvent>((event, emit) async {
      emit(state.copyWith(
          sortASC: !state.sortASC,
      ));
    });

    /// Refresh the temp unit from secure storage
    on<HistoryChangeUnitEvent>((event, emit) {
      emit(state.copyWith(
          isCelsius: !(state.isCelsius)
      ));
    });
  }

  Future<bool> getStoredTempUnit() async {
    var value = await SecureStorage.instance.get("tempUnit");
    if (value == "false") {
      return false;
    } else {
      return true;
    }
  }
}
