import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/features/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final user = FirebaseAuth.instance.currentUser!;

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
                            child: _userDetails(),
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          );
        }
      )
    );
  }

  _userDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(user.email ?? "E-mail unknown",style: AppTextStyle.primatyText ),
        const SizedBox(height: 16),
        Text("data", style: AppTextStyle.primatyText),
        Text("us", style: AppTextStyle.primatyText),
        const SizedBox(height: 16),
        Text("App by", style: AppTextStyle.primatyText),
        Text("Ködmön Dániel", style: AppTextStyle.author),
        Text("BME Flutter homework", style: AppTextStyle.primatyText),
        const SizedBox(height: 24),
        _logoutButton()
      ],
    );
  }

  _logoutButton() {
    return ElevatedButton.icon(
        icon: const Icon(Icons.logout, size: 20,),
        label: Text(AppLocalizations.of(context)!.logout),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5)
        ),
        onPressed: (){
          FirebaseAuth.instance.signOut();
        }
        );
  }
}






