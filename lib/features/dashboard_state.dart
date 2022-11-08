import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int currentTab;
  final bool isAdmin;

  const DashboardState({
    this.currentTab = 0,
    this.isAdmin = false
  });

  @override
  List<Object?> get props => [currentTab, isAdmin];

  DashboardState copyWith({int? currentTab, bool? isAdmin})
  => DashboardState(
    currentTab: currentTab ?? this.currentTab,
      isAdmin: isAdmin ?? this.isAdmin
  );
}

