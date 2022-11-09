import 'package:equatable/equatable.dart';

abstract class LoginSignupEvent extends Equatable {}

class LoginSignupSubmitEvent extends LoginSignupEvent {
  final String name;
  final String email;
  final String pwd;
  final String pwdAgain;
  final bool isAdmin;
  LoginSignupSubmitEvent(this.name, this.email, this.pwd, this.pwdAgain, this.isAdmin);

  @override
  List<Object?> get props => [];
}

class LoginSignupPwdHiddenEvent extends LoginSignupEvent {
  LoginSignupPwdHiddenEvent();

  @override
  List<Object?> get props => [];
}

class LoginSignupRoleSwitchChangeEvent extends LoginSignupEvent {
  LoginSignupRoleSwitchChangeEvent();

  @override
  List<Object?> get props => [];
}


