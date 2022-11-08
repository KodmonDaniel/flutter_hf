import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/api_repository.dart';
import '../repository/firestore/firestore_repository.dart';
import 'dashboard_state.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirestoreRepository firestoreRepository;

  DashboardBloc(this.firestoreRepository) : super(const DashboardState(currentTab: 0)) {

    on<DashboardTabChangeEvent>((event, emit) {
      emit(state.copyWith(
        currentTab: event.currentTab
      ));
    });

    on<DashboardRoleChangeEvent>((event, emit) async {
      await firestoreRepository.getRole(event.email).then((value) =>
          emit(state.copyWith(
              isAdmin: value

          ))
      ).catchError((error) {
      });
    });
  }
}