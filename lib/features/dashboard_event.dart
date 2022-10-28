import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardTabChangeEvent extends DashboardEvent {
  final int currentTab;
  DashboardTabChangeEvent(this.currentTab);

   List<Object?> get props => [currentTab];
}
