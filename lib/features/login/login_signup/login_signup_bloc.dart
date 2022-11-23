import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_signup_state.dart';
import 'login_signup_event.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';


class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  final FirestoreRepository firestoreRepository;

  LoginSignupBloc(this.firestoreRepository) : super(const LoginSignupState()) {
    on<LoginSignupSubmitEvent>((event, emit) async {
      bool isUsernameFree = false;

      emit(state.copyWith(
          isLoading: true,
          isEmailSyntaxError: false,
          isPwdShort: false,
          isEmptyField: false,
          isPwdMismatch: false,
          isUsernameNotAvailable: false,
      ));
      await firestoreRepository.getUserDetails(event.name, null).then((value) {
       if (value == null) isUsernameFree = true;
        });

      if (event.name != "" &&                 // empty field
          event.pwd != ""&&
          event.pwdAgain != "" &&
          event.email != "") {
        if (isUsernameFree) {                 // free username
          if (event.pwd == event.pwdAgain) { // PWD mismatch
            if (event.pwd.length > 5) {
              if (_validEmail(event.email)) { // email syntax
                await firestoreRepository.signUp(
                    event.name, event.pwd, event.email, event.isAdmin).then((
                    value) =>
                    emit(state.copyWith(
                        successSignup: value,
                        isLoading: false
                    ))
                ).catchError((error) {});
              } else {
                emit(state.copyWith(
                  isEmailSyntaxError: true,
                  isLoading: false,
                ));
              }
            } else {
            emit(state.copyWith(
              isPwdShort: true,
              isLoading: false,
            ));
            }
          } else {
            emit(state.copyWith(
              isPwdMismatch: true,
              isLoading: false,
            ));
          }
        } else {
          emit(state.copyWith(
            isUsernameNotAvailable: true,
            isLoading: false,
          ));
        }
      } else {
        emit(state.copyWith(
          isEmptyField: true,
          isLoading: false,
        ));
      }
    });

    on<LoginSignupPwdHiddenEvent>((event, emit) {
      emit(state.copyWith(
          isPwdHidden: !(state.isPwdHidden)
      ));
    });

    on<LoginSignupRoleSwitchChangeEvent>((event, emit) {
      emit(state.copyWith(
          isAdminSet: !(state.isAdminSet)
      ));
    });
  }

  bool _validEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}