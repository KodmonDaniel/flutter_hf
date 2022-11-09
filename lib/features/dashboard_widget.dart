import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/features/history/history_bloc.dart';
import 'package:flutter_hf/features/history/history_widget.dart';
import 'package:flutter_hf/features/profile/profile_widget.dart';
import 'package:flutter_hf/features/splash.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:flutter_hf/features/weather/weather_event.dart';
import 'package:flutter_hf/features/weather/weather_widget.dart';
import 'package:flutter_hf/repository/firestore/models/user_details.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_page.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'dashboard_bloc.dart';
import 'package:custom_top_navigator/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'history/history_event.dart';
import 'login/login_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard ({Key? key});
  @override
  State<StatefulWidget> createState() => _DashboardState();
  }

class _DashboardState extends State<Dashboard> {

  /// First screens to display
  var login = const Login();

  /// The actual widget with switcher
  late Widget screen;

  /// Tabs
  late Weather weather;
  late History history;
  late Profile profile;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    //refresh userdetails

    timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      print("tick");
      Provider.of<WeatherBloc>(context, listen: false).add(CitiesWeatherRefreshEvent());    //todo role
        if (false) {
          print("ADMIN WRITE-----------------------------------------------------------");
          //Provider.of<WeatherBloc>(context, listen: false).add(CitiesWeatherSaveEvent());
        }
    });

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tab getTabFromIndex(int index){
      switch (index) {
        case 1:
          return Tab(const Profile(),
              AppLocalizations.of(context)!.tab_profile,
              const Icon(Icons.supervised_user_circle));
        case 2:
          return Tab(const History(),
              AppLocalizations.of(context)!.tab_history,
              const Icon(Icons.history));
        default:
          return Tab(const Weather(),
              AppLocalizations.of(context)!.tab_weather,
          const Icon(Icons.sunny));
      }
    }

    onUserChanged() {
      Provider.of<DashboardBloc>(context).add(DashboardUserDetailsReloadEvent(FirebaseAuth.instance.currentUser!.email!));
      Provider.of<DashboardBloc>(context).add(DashboardTabChangeEvent(0));
      Provider.of<WeatherBloc>(context).add(CitiesWeatherRefreshEvent());
      Provider.of<HistoryBloc>(context).add(HistoryRefreshEvent());
    }

    getDashboard(int currentTab, BuildContext context, DashboardState state) {
      var numOfTabs = (state.userDetails?.admin ?? false) ? 2 : 3;
      return CustomScaffold(
        scaffold: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.textPrimary,
            unselectedItemColor: AppColors.textSecondary,
            elevation: 3,
            currentIndex: currentTab,
            backgroundColor: AppColors.backgroundDark,
            items: [
              for (var i = 0; i < numOfTabs; i++) BottomNavigationBarItem(
                  icon: getTabFromIndex(i).icon,
                  label: getTabFromIndex(i).name
              )
            ],
          ),
        ),
          children: [
            for (var i = 0; i < numOfTabs ; i++) getTabFromIndex(i).widget
          ],
          onItemTap: (index) =>
              Provider.of<DashboardBloc>(context, listen: false).add(DashboardTabChangeEvent(index)),
      );
    }
    //todo showDialog az első indításra
    onUserChanged();
    return BlocProvider.value(
      value: Provider.of<DashboardBloc>(context),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          screen = getDashboard(state.currentTab, context, state);
          return screen;
          },
      ),
    );
  }
}

class Tab {
  DashboardPage widget;
  String name;
  Icon icon;

  Tab(this.widget, this.name, this.icon);
}