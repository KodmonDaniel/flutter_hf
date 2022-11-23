import 'package:equatable/equatable.dart';

class LoginSignupState extends Equatable {
  final bool isLoading;
  final bool isEmptyField;
  final bool isUsernameNotAvailable;
  final bool isPwdMismatch;
  final bool isEmailSyntaxError;
  final bool isPwdShort;
  final bool isPwdHidden;
  final bool isAdminSet;
  final bool? successSignup;  // 0 = no state, 1 = failed, 2 = success  todo nem kell ez medoldva


  const LoginSignupState({
    this.isLoading = false,
    this.isEmptyField = false,
    this.isUsernameNotAvailable = false,
    this.isPwdMismatch = false,
    this.isEmailSyntaxError = false,
    this.isPwdShort = false,
    this.isPwdHidden = true,
    this.isAdminSet = false,
    this.successSignup
  });

  @override
  List<Object?> get props => [isLoading, isEmptyField, isUsernameNotAvailable, isPwdMismatch, isEmailSyntaxError, isPwdShort, isPwdHidden, isAdminSet, successSignup];

  LoginSignupState copyWith({bool? isLoading, bool? isEmptyField, bool? isUsernameNotAvailable, bool? isPwdMismatch, bool? isEmailSyntaxError, bool? isPwdShort, bool? isPwdHidden, bool? isAdminSet, bool? successSignup})
  => LoginSignupState(
      isLoading: isLoading ?? this.isLoading,
      isEmptyField: isEmptyField ?? this.isEmptyField,
      isUsernameNotAvailable: isUsernameNotAvailable ?? this.isUsernameNotAvailable,
      isPwdMismatch: isPwdMismatch ?? this.isPwdMismatch,
      isEmailSyntaxError: isEmailSyntaxError ?? this.isEmailSyntaxError,
      isPwdShort: isPwdShort ?? this.isPwdShort,
      isPwdHidden: isPwdHidden ?? this.isPwdHidden,
      isAdminSet: isAdminSet ?? this.isAdminSet,
      successSignup: successSignup
  );
}