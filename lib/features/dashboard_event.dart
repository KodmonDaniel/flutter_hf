import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardTabChangeEvent extends DashboardEvent {
  final int currentTab;
  DashboardTabChangeEvent(this.currentTab);

  @override
  List<Object?> get props => [currentTab];
}

class DashboardRoleChangeEvent extends DashboardEvent {
  final String email;
  DashboardRoleChangeEvent(this.email);

  @override
  List<Object?> get props => [];
}
