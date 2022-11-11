import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';

class HistoryState extends Equatable {
  final List<StoredWeather>? storedWeathers;
  final bool isCelsius;
  final bool isLoading;
  final bool sortByTime;
  final bool sortASC;

  const HistoryState({
    this.storedWeathers,
    this.isCelsius = true,    // default value, overridden by secure storage at init.
    this.isLoading = true,
    this.sortByTime = true,
    this.sortASC = true
  });

  @override
  List<Object?> get props => [storedWeathers, isCelsius,  isLoading, sortByTime, sortASC];

  HistoryState copyWith({List<StoredWeather>? storedWeathers, bool? isLoading, bool? isCelsius, bool? sortByTime, bool? sortASC})
  => HistoryState(
      storedWeathers: storedWeathers ?? this.storedWeathers,
      isLoading: isLoading ?? this.isLoading,
      isCelsius: isCelsius ?? this.isCelsius,
      sortByTime: sortByTime ?? this.sortByTime,
      sortASC: sortASC ?? this.sortASC
  );
}