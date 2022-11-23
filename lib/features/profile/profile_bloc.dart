import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hf/features/weather/weather_state.dart';
import 'package:flutter_hf/features/weather/weather_widget.dart';
import '../../preferences/secure_storage.dart';
import '../../repository/firestore/firestore_repository.dart';
import 'profile_state.dart';
import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepository firestoreRepository;

  ProfileBloc(this.firestoreRepository) : super(const ProfileState()){

    on<ProfileUserDetailsReloadEvent>((event, emit) async {
      bool tempUnit = await getStoredTempUnit();
      await firestoreRepository.getUserDetails(null, event.email).then((value) =>
          emit(state.copyWith(
              userDetails: value,
              isCelsius: tempUnit
          ))
      ).catchError((error) {
      });
    });

    on<ProfileChangeUnitEvent>((event, emit) async {
      bool tempUnit = await getStoredTempUnit();
      await SecureStorage.instance.set("tempUnit", (!tempUnit).toString());
          emit(state.copyWith(
              isCelsius: !tempUnit
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