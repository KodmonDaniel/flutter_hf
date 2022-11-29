import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../preferences/secure_storage.dart';
import '../../repository/firestore/firestore_repository.dart';
import 'profile_state.dart';
import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepository firestoreRepository;

  ProfileBloc(this.firestoreRepository) : super(ProfileState()){

    on<ProfileChangeUnitEvent>((event, emit) async {
      await SecureStorage.instance.set("tempUnit", (event.isCelsius).toString());
    });
  }
}