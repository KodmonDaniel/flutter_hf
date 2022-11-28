import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/extensions/extension_theme.dart';
import 'package:flutter_hf/injector.dart';
import 'package:flutter_hf/observer.dart';
import 'package:flutter_hf/preferences/secure_storage.dart';
import 'package:flutter_hf/preferences/common_objects.dart';
import 'package:flutter_hf/repository/firestore/models/user_details_response.dart';
import 'package:provider/provider.dart';
import 'features/dashboard_widget.dart';
import 'features/login/login_widget.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: Injector.providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          title: "WeatherNOW",
          theme: AppTheme.primary,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //return Dashboard();
                  return FutureBuilder(
                      future: Future.wait([
                        Injector.firestoreRepository.getUserDetails(null, snapshot.data!.email.toString()),
                        _getStoredTempUnit(),
                        _isFirstLaunch()
                      ]),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          Provider.of<CommonObjects>(context, listen: false).userDetails = UserDetailsResponse.fromJson(snapshot.data![0].toJson());
                          Provider.of<CommonObjects>(context, listen: false).isCelsius = snapshot.data![1];
                          Provider.of<CommonObjects>(context, listen: false).firstLaunch = snapshot.data![2];
                          return /*_loadingWidget(); */const Dashboard();
                        } else {
                          return _loadingWidget();
                        }
                      }
                  );
                } else {
                  return const Login();
                }
              })
        )
    );
  }

  Future<bool> _getStoredTempUnit() async {
    var value = await SecureStorage.instance.get("tempUnit");
    if (value == "false") {
      return false;
    } else {
      return true;
    }
  }
  Future<bool> _isFirstLaunch() async {
    var value = await SecureStorage.instance.get("firstLaunch");
    if (value == null) {
      return true;
    } else {
      return false;
    }
  }

  _loadingWidget() {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/launch/main_bg.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(60))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25),

                                child: LoadingAnimationWidget.hexagonDots(
                                    color: AppColors.tealColor4,
                                    size: 75),
                          ),
                        ),
            )



          ],
        )
    );
  }
}