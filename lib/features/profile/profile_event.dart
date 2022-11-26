import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileChangeUnitEvent extends ProfileEvent {
  final bool isCelsius;
  ProfileChangeUnitEvent(this.isCelsius);

  @override
  List<Object?> get props => [];
}
