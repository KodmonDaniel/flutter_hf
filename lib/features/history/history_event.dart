import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {}

class HistoryRefreshEvent extends HistoryEvent {
  HistoryRefreshEvent();

  @override
  List<Object?> get props => [];
}
