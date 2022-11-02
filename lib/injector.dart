import 'package:flutter_hf/features/dashboard_bloc.dart';
import 'package:flutter_hf/features/history/history_bloc.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:flutter_hf/repository/api/api_repository.dart';
import 'package:provider/provider.dart';
import 'features/profile/profile_bloc.dart';

class Injector {
  static final providers = [
    Provider<ApiRepository>(create: (_) => apiRepository),
    Provider<DashboardBloc>(create: (_) => blocDashboard),
    Provider<WeatherBloc>(create: (_) => blocWeather),
    Provider<HistoryBloc>(create: (_) => blocHistory),
    Provider<ProfileBloc>(create: (_) => profileDashboard),
  ];

  static final apiRepository = ApiRepository();
  static final blocDashboard = DashboardBloc();
  static final blocWeather = WeatherBloc(apiRepository);
  static final blocHistory = HistoryBloc(apiRepository);
  static final profileDashboard = ProfileBloc();
}