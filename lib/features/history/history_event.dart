import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {}

class HistoryRefreshEvent extends HistoryEvent {
  HistoryRefreshEvent();

  @override
  List<Object?> get props => [];
}

class HistoryChangeSortCategoryEvent extends HistoryEvent {
  final bool sortByTime;
  HistoryChangeSortCategoryEvent(this.sortByTime);

  @override
  List<Object?> get props => [sortByTime];
}

class HistoryChangeOrderCategoryEvent extends HistoryEvent {
  final bool sortASC;
  HistoryChangeOrderCategoryEvent(this.sortASC);

  @override
  List<Object?> get props => [];
}
