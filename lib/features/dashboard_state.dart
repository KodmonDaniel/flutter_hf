import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int currentTab;

  const DashboardState({
    this.currentTab = 0,
  });

  @override
  List<Object?> get props => [currentTab];

  DashboardState copyWith({int? currentTab})
  => DashboardState(
      currentTab: currentTab ?? this.currentTab,
  );
}

