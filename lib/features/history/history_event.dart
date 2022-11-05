import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {}

class HistoryRefreshEvent extends HistoryEvent {
  HistoryRefreshEvent();

  @override
  List<Object?> get props => [];
}

class HistoryChangeSortCategoryEvent extends HistoryEvent {
  HistoryChangeSortCategoryEvent();

  @override
  List<Object?> get props => [];
}

class HistoryChangeOrderCategoryEvent extends HistoryEvent {
  HistoryChangeOrderCategoryEvent();

  @override
  List<Object?> get props => [];
}
