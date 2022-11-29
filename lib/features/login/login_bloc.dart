import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import 'login_event.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirestoreRepository firestoreRepository;

  LoginBloc(this.firestoreRepository) : super(const LoginState()) {
    on<LoginSubmitEvent>((event, emit) async {
      emit(state.copyWith(
          isPwdError: false,
          isUsernameError: false,
          isLoading: true
      ));
      await firestoreRepository.getUserDetails(event.name, null).then((value) =>
          emit(state.copyWith(
              userDetails: value
          ))
      ).catchError((error) {});
      if (state.userDetails != null) {// set userDetails BEFORE Firebase signIn
        emit(state.copyWith(
            userDetailsLoaded: true
        ));
        await firestoreRepository.signIn(state.userDetails?.email ?? "", event.pwd).then((_) async {
          // successful popup to myapp
          emit(state.copyWith(
              isLoading: false,
          ));
        }).catchError((error) {
          // bad pwd
          emit(state.copyWith(
              isLoading: false,
              isPwdError: true
          ));
        });
      } else {
        // bad uname
        emit(state.copyWith(
          isLoading: false,
          isUsernameError: true,
        ));
      }
    });

    on<LoginPwdHiddenEvent>((event, emit) {
      emit(state.copyWith(
          isPwdHidden: !(state.isPwdHidden)
      ));
    });
  }

}