import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/user_details.dart';

class DashboardState extends Equatable {
  final int currentTab;
  final UserDetails? userDetails;

  const DashboardState({
    this.currentTab = 0,
    this.userDetails
  });

  @override
  List<Object?> get props => [currentTab, userDetails];

  DashboardState copyWith({int? currentTab, UserDetails? userDetails})
  => DashboardState(
    currentTab: currentTab ?? this.currentTab,
      userDetails: userDetails ?? this.userDetails
  );
}

