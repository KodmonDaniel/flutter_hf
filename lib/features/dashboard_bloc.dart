import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/api_repository.dart';
import 'dashboard_state.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(const DashboardState(currentTab: 0)) {

    on<DashboardTabChangeEvent>((event, emit) {
      emit(state.copyWith(
        currentTab: event.currentTab
      ));
    });
  }
}