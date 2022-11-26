import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/firestore/firestore_repository.dart';
import 'dashboard_state.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirestoreRepository firestoreRepository;

  DashboardBloc(this.firestoreRepository) : super(const DashboardState(currentTab: 0)) {

    on<DashboardTabChangeEvent>((event, emit) async {
      emit(state.copyWith(
          currentTab: event.currentTab,
          //userDetails: await _getUserDetails()
      ));
    });

   /* on<DashboardUserDetailsChangeEvent>((event, emit) async {
          emit(state.copyWith(
              userDetails: event.userDetails
          ));
    });*/

   /* on<DashboardUserDetailsReloadEvent>((event, emit) async {
      await firestoreRepository.getUserDetails(null, event.email).then((value) =>
          emit(state.copyWith(
              userDetails: value
          ))
      ).catchError((error) {
      });
    });
*/

    on<DashboardUserDetailsReloadEvent>((event, emit) async {
     // await firestoreRepository.getUserDetails(null, event.email).then((value) =>
         // DashboardState.setUserDetails(value)
     // ).catchError((error) {
     // });
    });
  }

 /* _getUserDetails() async {
    final userDetailsJson = await SecureStorage.instance.get("userDetails");
    return UserDetails.fromJson(json.decode(userDetailsJson!));
  }*/

}