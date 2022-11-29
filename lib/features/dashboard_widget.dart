import 'dart:async';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_gradient.dart';
import 'package:flutter_hf/features/history/history_bloc.dart';
import 'package:flutter_hf/features/history/history_widget.dart';
import 'package:flutter_hf/features/profile/profile_widget.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:flutter_hf/features/weather/weather_event.dart';
import 'package:flutter_hf/features/weather/weather_widget.dart';
import 'package:flutter_hf/preferences/common_objects.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../extensions/extension_textstyle.dart';
import 'dashboard_page.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'dashboard_bloc.dart';
import 'package:custom_top_navigator/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'history/history_event.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  const Dashboard ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
  }

class _DashboardState extends State<Dashboard> {

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

    if (Provider.of<CommonObjects>(context, listen: false).firstLaunch!) {
      Future.delayed(Duration.zero,() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: _welcomeAlert(context),
            );
          },
        );
      });
      Provider.of<DashboardBloc>(context, listen: false).add(DashboardFirstLaunchedEvent());
      Provider.of<CommonObjects>(context, listen: false).firstLaunch = false;
    }

    timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      Provider.of<WeatherBloc>(context, listen: false).add(CitiesWeatherRefreshEvent());
        if (Provider.of<CommonObjects>(context, listen: false).userDetails?.admin ?? false) {
          Provider.of<WeatherBloc>(context, listen: false).add(CitiesWeatherSaveEvent());
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
      Provider.of<DashboardBloc>(context).add(DashboardTabChangeEvent(0));
      Provider.of<WeatherBloc>(context).add(CitiesWeatherRefreshEvent());
      Provider.of<HistoryBloc>(context).add(HistoryRefreshEvent());
    }

    getDashboard(int currentTab, BuildContext context, DashboardState state) {
      var numOfTabs = (Provider.of<CommonObjects>(context).userDetails?.admin ?? false) ? 2 : 3;
      return CustomScaffold(
        scaffold: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.tealColor1,
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

  /// Alert dialog for first app launch
  _welcomeAlert(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            width: 400,
            decoration: BoxDecoration(
              gradient: AppGradient.blueTealGrad,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
            ),
            child: Center(
                child: Text(AppLocalizations.of(context)!.welcome_title, style: AppTextStyle.bigTitle.copyWith(color: AppColors.white),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.welcome_text, style: AppTextStyle.descText, textAlign: TextAlign.center,),
                InkWell(
                  onTap: () async {
                    _launchUrl();
                  },
                  child: Text("https://github.com/KodmonDaniel/flutter_hf", style: AppTextStyle.miniBtnText, textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.backgroundDark, width: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.welcome_btn, style: AppTextStyle.btnText.copyWith(color: AppColors.backgroundDark)),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://github.com/KodmonDaniel/flutter_hf');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class Tab {
  DashboardPage widget;
  String name;
  Icon icon;

  Tab(this.widget, this.name, this.icon);
}


