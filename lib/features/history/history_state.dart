import 'package:equatable/equatable.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';

class HistoryState extends Equatable {
  final List<StoredWeather>? storedWeathers;
  final bool isCelsius;
  final bool isLoading;

  const HistoryState({
    this.storedWeathers,
    this.isCelsius = true,   //todo save secur. storage
    this.isLoading = true
  });

  @override
  List<Object?> get props => [storedWeathers, isLoading];

  HistoryState copyWith({List<StoredWeather>? storedWeathers, bool? isLoading, bool? isCelsius})
  => HistoryState(
      storedWeathers: storedWeathers,
      isLoading: isLoading ?? this.isLoading,
      isCelsius: isCelsius ?? this.isCelsius
  );
}