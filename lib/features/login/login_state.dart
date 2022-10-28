import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final int currentTab;

  const LoginState({
    this.currentTab = 0
  });

  @override
  List<Object?> get props => [currentTab];

  LoginState copyWith({int? currentTab})
  => LoginState(
      currentTab: currentTab ?? this.currentTab
  );
}