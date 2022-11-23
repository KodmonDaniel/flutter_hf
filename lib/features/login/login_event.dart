import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginSubmitEvent extends LoginEvent {
  final String name;
  final String pwd;
  LoginSubmitEvent(this.name, this.pwd);

  @override
  List<Object?> get props => [];
}

class LoginPwdHiddenEvent extends LoginEvent {
  LoginPwdHiddenEvent();

  @override
  List<Object?> get props => [];
}

