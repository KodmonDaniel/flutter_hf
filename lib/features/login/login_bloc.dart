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
              isLoading: true
      ));
      await firestoreRepository.getUserDetails(event.name).then((value) =>
          emit(state.copyWith(
              /*storedWeathers: value,
              isLoading: false,
              errorState: false*/
            userDetails: value

          ))
      ).catchError((error) {
        print(error.toString() + "    <---");
      });
      if (state.userDetails != null) {
        await firestoreRepository.signIn(state.userDetails?.email ?? "", event.pwd).then((_) =>
            emit(state.copyWith(
              isLoading: false,
            ))
        ).catchError((error) {});
        print("FINISH OK TO START");
       // Provider.of<DashboardBloc>(context, listen: false).add(DashboardRoleChangeEvent(state.userDetails?.admin ?? false));
      } else {
        print("LOGINERROR");
      }


    });
  }
}