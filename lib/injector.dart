import 'package:flutter_hf/features/dashboard_bloc.dart';
import 'package:flutter_hf/features/history/history_bloc.dart';
import 'package:flutter_hf/features/login/login_state.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:flutter_hf/repository/api/api_repository.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import 'package:provider/provider.dart';
import 'features/login/login_bloc.dart';
import 'features/profile/profile_bloc.dart';

class Injector {
  static final providers = [
    Provider<ApiRepository>(create: (_) => apiRepository),
    Provider<FirestoreRepository>(create: (_) => firestoreRepository),
    Provider<LoginBloc>(create: (_) => blocLogin),
    Provider<DashboardBloc>(create: (_) => blocDashboard),
    Provider<WeatherBloc>(create: (_) => blocWeather),
    Provider<HistoryBloc>(create: (_) => blocHistory),
    Provider<ProfileBloc>(create: (_) => blocProfile),
  ];

  static final apiRepository = ApiRepository();
  static final firestoreRepository = FirestoreRepository();
  static final blocLogin = LoginBloc(firestoreRepository);
  static final blocDashboard = DashboardBloc(firestoreRepository);
  static final blocWeather = WeatherBloc(apiRepository, firestoreRepository);
  static final blocHistory = HistoryBloc(firestoreRepository);
  static final blocProfile = ProfileBloc();
}