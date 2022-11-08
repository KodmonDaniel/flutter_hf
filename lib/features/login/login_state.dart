import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/user_details.dart';

class LoginState extends Equatable {
  final UserDetails? userDetails;
  final bool isLoading;

  const LoginState({
    this.userDetails,
    this.isLoading = true
  });

  @override
  List<Object?> get props => [userDetails, isLoading];

  LoginState copyWith({UserDetails? userDetails, bool? isLoading})
  => LoginState(
      userDetails: userDetails ?? this.userDetails,
      isLoading: isLoading ?? this.isLoading
  );
}