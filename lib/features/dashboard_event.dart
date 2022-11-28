import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardTabChangeEvent extends DashboardEvent {
  final int currentTab;
  DashboardTabChangeEvent(this.currentTab);

  @override
  List<Object?> get props => [currentTab];
}

class DashboardFirstLaunchedEvent extends DashboardEvent {
  DashboardFirstLaunchedEvent();

  @override
  List<Object?> get props => [];
}

class DashboardInitEvent extends DashboardEvent {
  DashboardInitEvent();

  @override
  List<Object?> get props => [];
}
