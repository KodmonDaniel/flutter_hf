import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/user_details_response.dart';

class LoginState extends Equatable {
  final UserDetailsResponse? userDetails;
  final bool isLoading;
  final bool isUsernameError;
  final bool isPwdError;
  final bool isPwdHidden;

  const LoginState({
    this.userDetails,
    this.isLoading = false,
    this.isUsernameError = false,
    this.isPwdError = false,
    this.isPwdHidden = true
  });

  @override
  List<Object?> get props => [userDetails, isLoading, isUsernameError, isPwdError, isPwdHidden];

  LoginState copyWith({UserDetailsResponse? userDetails, bool? isLoading, bool? isUsernameError, bool? isPwdError, bool? isPwdHidden})
  => LoginState(
      userDetails: userDetails ?? this.userDetails,
      isLoading: isLoading ?? this.isLoading,
      isUsernameError: isUsernameError ?? this.isUsernameError,
      isPwdError: isPwdError ?? this.isPwdError,
      isPwdHidden: isPwdHidden ?? this.isPwdHidden
  );
}