import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/features/dashboard_page.dart';
import 'package:flutter_hf/features/history/history_bloc.dart';
import 'package:flutter_hf/features/profile/profile_event.dart';
import 'package:flutter_hf/features/weather/weather_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../extensions/extension_gradient.dart';
import '../history/history_event.dart';
import '../weather/weather_event.dart';
import 'profile_state.dart';
import 'profile_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends DashboardPage {
  const Profile ({Key? key});
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Provider.of<ProfileBloc>(context),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Platform.isAndroid ? AssetImage("assets/images/background/profile_bg.png") : AssetImage("assets/images/background/profile_bg.png"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 60, top: 32, right: 60, bottom: 32),

                          child: Card(
                            color: AppColors.cardDark,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)
                            ),
                            child: SizedBox(
                              width: 300,
                              height: 450,
                              child: _cardContent(state),
                            ),
                          ),
                        )
                        ],
                    ),

                )
                ) ],
            )
          );
        }
      )
    );
  }

  _cardContent(ProfileState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _userDetails(state),
        _tempSwitch(state),
        _credits()
      ],
    );
  }

  _userDetails(ProfileState state) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(state.userDetails?.username ?? "N/A",style: AppTextStyle.usernameText ),
          const SizedBox(height: 10),
          Text(state.userDetails?.email ?? "N/A",style: AppTextStyle.primaryText ),
          const SizedBox(height: 10),
          Text("${(state.userDetails?.admin ?? false)
              ? AppLocalizations.of(context)!.admin
              : AppLocalizations.of(context)!.basic} user",
              style: AppTextStyle.primaryText2 ),
          //const SizedBox(height: 10),

        ]);
  }

  _tempSwitch(ProfileState state) {
    return ToggleSwitch(
      minWidth: 50,
      cornerRadius: 20,
      activeBgColor: [AppColors.tealColor3],
      activeFgColor: AppColors.textWhite,
      inactiveBgColor: AppColors.lightGrey,
      inactiveFgColor: AppColors.backgroundDark,
      fontSize: 18,
      initialLabelIndex: state.isCelsius ? 0 : 1,
      totalSwitches: 2,
      labels:  const ["°C", "°F"],
      radiusStyle: true,
      onToggle: (index) {
        Provider.of<ProfileBloc>(context, listen: false).add(ProfileChangeUnitEvent());
        Provider.of<WeatherBloc>(context, listen: false).add(CitiesWeatherChangeUnitEvent());
        Provider.of<HistoryBloc>(context, listen: false).add(HistoryChangeUnitEvent());
      },
    );
  }

  _credits() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.profile_credit1, style: AppTextStyle.primaryText),
          Text(AppLocalizations.of(context)!.profile_credit2, style: AppTextStyle.primarySizedText),
          Text(AppLocalizations.of(context)!.profile_credit3, style: AppTextStyle.primaryText),
          const SizedBox(height: 24),
          _logoutButton()
        ]
    );
  }

  _logoutButton() {
    return Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
            gradient:AppGradient.blueTealGrad,
            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () => FirebaseAuth.instance.signOut(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(AppLocalizations.of(context)!.logout, style: AppTextStyle.btnText),
              ),
            ),
          ),
        )
    );
  }
}






