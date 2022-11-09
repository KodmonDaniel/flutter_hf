import 'package:equatable/equatable.dart';

class LoginSignupState extends Equatable {
  final bool isLoading;
  final bool isEmptyField;
  final bool isUsernameNotAvailable;
  final bool isPwdMismatch;
  final bool isPwdHidden;
  final bool isAdminSet;


  const LoginSignupState({
    this.isLoading = false,
    this.isEmptyField = false,
    this.isUsernameNotAvailable = false,
    this.isPwdMismatch = false,
    this.isPwdHidden = true,
    this.isAdminSet = false
  });

  @override
  List<Object?> get props => [isLoading, isEmptyField, isUsernameNotAvailable, isPwdMismatch, isPwdHidden, isAdminSet];

  LoginSignupState copyWith({bool? isLoading, bool? isEmptyField, bool? isUsernameNotAvailable, bool? isPwdMismatch, bool? isPwdHidden, bool? isAdminSet})
  => LoginSignupState(
      isLoading: isLoading ?? this.isLoading,
      isEmptyField: isEmptyField ?? this.isEmptyField,
      isUsernameNotAvailable: isUsernameNotAvailable ?? this.isUsernameNotAvailable,
      isPwdMismatch: isPwdMismatch ?? this.isPwdMismatch,
      isPwdHidden: isPwdHidden ?? this.isPwdHidden,
      isAdminSet: isAdminSet ?? this.isAdminSet
  );
}