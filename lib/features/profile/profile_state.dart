import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final bool isCelsius;

  const ProfileState({
    this.isCelsius = true,  // default value, overridden by secure storage at init.
  });

  @override
  List<Object?> get props => [isCelsius];

  ProfileState copyWith({bool? isCelsius})
  => ProfileState(
      isCelsius: isCelsius ?? this.isCelsius,
  );
}