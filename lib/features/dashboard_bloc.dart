import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hf/repository/firestore/models/user_details_response.dart';
import '../preferences/secure_storage.dart';
import '../repository/firestore/firestore_repository.dart';
import 'dashboard_state.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirestoreRepository firestoreRepository;

  DashboardBloc(this.firestoreRepository) : super(const DashboardState(currentTab: 0)) {

    on<DashboardTabChangeEvent>((event, emit) async {
      emit(state.copyWith(
          currentTab: event.currentTab,
      ));
    });

    on<DashboardFirstLaunchedEvent>((event, emit) async {
      await SecureStorage.instance.set("firstLaunch", "false");
      });

    on<DashboardInitEvent>((event, emit) async {
     // await firestoreRepository.getUserDetails(name, email)
    });
  }

  Future<UserDetailsResponse> getUserDetails() async {
    UserDetailsResponse? response = await firestoreRepository.getUserDetails(null, FirebaseAuth.instance.currentUser?.email.toString());
    var userDetails = UserDetailsResponse.fromJson(response!.toJson());
    return userDetails;
  }

  Future<bool> getStoredTempUnit() async {
    var value = await SecureStorage.instance.get("tempUnit");
    if (value == "false") {
      return false;
    } else {
      return true;
    }
  }
  Future<bool> isFirstLaunch() async {
    var value = await SecureStorage.instance.get("firstLaunch");
    if (value == null) {
      return true;
    } else {
      return false;
    }
  }
}