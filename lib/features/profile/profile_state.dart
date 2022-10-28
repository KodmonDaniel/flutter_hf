import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final int currentTab;

  const ProfileState({
    this.currentTab = 0
  });

  @override
  List<Object?> get props => [currentTab];

  ProfileState copyWith({int? currentTab})
  => ProfileState(
      currentTab: currentTab ?? this.currentTab
  );
}