import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileUserDetailsReloadEvent extends ProfileEvent {
  final String email;
  ProfileUserDetailsReloadEvent(this.email);

  @override
  List<Object?> get props => [];
}

class ProfileChangeUnitEvent extends ProfileEvent {
  ProfileChangeUnitEvent();

  @override
  List<Object?> get props => [];
}
