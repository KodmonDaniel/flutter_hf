import 'package:equatable/equatable.dart';
//import 'package:flutter_hf/repository/firestore/models/user_details.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardTabChangeEvent extends DashboardEvent {
  final int currentTab;
  DashboardTabChangeEvent(this.currentTab);

  @override
  List<Object?> get props => [currentTab];
}
/*
class DashboardUserDetailsChangeEvent extends DashboardEvent {
  final UserDetails userDetails;
  DashboardUserDetailsChangeEvent(this.userDetails);

  @override
  List<Object?> get props => [];
}
*/
class DashboardUserDetailsReloadEvent extends DashboardEvent {
  final String email;
  DashboardUserDetailsReloadEvent(this.email);

  @override
  List<Object?> get props => [];
}
