import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/features/profile/profile_widget.dart';
import 'package:flutter_hf/features/splash.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:flutter_hf/features/weather/weather_event.dart';
import 'package:flutter_hf/features/weather/weather_widget.dart';
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

import 'login/login_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard ({Key? key});
  @override
  State<StatefulWidget> createState() => _DashboardState();
  }

class _DashboardState extends State<Dashboard> {

  /// First screens to display
  var login = const Login();
  var splash = Splash();

  /// The actual widget with switcher
  late Widget screen;

  /// Tabs
  late Weather weather;
  late Profile profile;

  int numOfTabs = 3;

  @override
  Widget build(BuildContext context) {
    screen = splash;

    Tab getTabFromIndex(int index){
      switch (index) {
        case 1:
          return Tab(const Profile(),
              AppLocalizations.of(context)!.tab_history,
              const Icon(Icons.history));
        case 2:
          return Tab(const Profile(),
              AppLocalizations.of(context)!.tab_profile,
              const Icon(Icons.supervised_user_circle));
        default:
          return Tab(const Weather(),
              AppLocalizations.of(context)!.tab_weather,
          const Icon(Icons.sunny));
      }
    }

    onUserChanged() {
      Provider.of<DashboardBloc>(context).add(DashboardTabChangeEvent(0));
      Provider.of<WeatherBloc>(context).add(CitiesWeatherRefreshEvent());


    }

    getDashboard(int currentTab, BuildContext context) {
      return CustomScaffold(
        scaffold: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.textPrimary,  //TODO EXTENSION
            unselectedItemColor: AppColors.textSecondary,
            elevation: 3,
            currentIndex: currentTab,
            backgroundColor: AppColors.backgroundDark,
            items: [
              for (var i = 0; i < numOfTabs ; i++) BottomNavigationBarItem(
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

  /*  return BlocProvider.value(
      value: Provider.of<DashboardBloc>(context),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {

        },
      ),
    );*/

    //TODO PELDA: http://api.openweathermap.org/data/2.5/group?id=722437,3054643&appid=522e009a484c7953360917c5a4ec1428

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("LOGIN SUCCESS---------------");
          onUserChanged();
          return BlocProvider.value(
            value: Provider.of<DashboardBloc>(context),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                screen = getDashboard(state.currentTab, context);
                return screen;
              },
            ),
          );


        } else {
          Future.delayed(const Duration(seconds: 1));
          screen = login;
          return screen;
        }
        //todo anim
        return screen;
      }
    );

  }
}



class Tab {
  DashboardPage widget;
  String name;
  Icon icon;

  Tab(this.widget, this.name, this.icon);
}