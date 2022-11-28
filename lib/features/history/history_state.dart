import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';

class HistoryState extends Equatable {
  final List<StoredWeather>? storedWeathers;
  final bool isLoading;
  final bool sortByTime;
  final bool sortASC;

  const HistoryState({
    this.storedWeathers,
    this.isLoading = true,
    this.sortByTime = true,
    this.sortASC = true
  });

  @override
  List<Object?> get props => [storedWeathers, isLoading, sortByTime, sortASC];

  HistoryState copyWith({List<StoredWeather>? storedWeathers, bool? isLoading, bool? sortByTime, bool? sortASC})
  => HistoryState(
      storedWeathers: storedWeathers ?? this.storedWeathers,
      isLoading: isLoading ?? this.isLoading,
      sortByTime: sortByTime ?? this.sortByTime,
      sortASC: sortASC ?? this.sortASC
  );
}