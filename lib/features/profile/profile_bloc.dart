import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileBloc() : super(const ProfileState());
}