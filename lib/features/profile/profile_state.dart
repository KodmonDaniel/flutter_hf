import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/user_details.dart';

class ProfileState extends Equatable {
  final bool isCelsius;
  final UserDetails? userDetails;

  const ProfileState({
    this.isCelsius = true,  // default value, overridden by secure storage at init.
    this.userDetails
  });

  @override
  List<Object?> get props => [isCelsius, userDetails];

  ProfileState copyWith({bool? isCelsius, UserDetails? userDetails})
  => ProfileState(
      isCelsius: isCelsius ?? this.isCelsius,
      userDetails: userDetails ?? this.userDetails
  );
}