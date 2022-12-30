import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
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
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.sysNavBar
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  Bloc.observer = Observer();

  // Async tasks during splash screen.
  final user = FirebaseAuth.instance.currentUser;
  UserDetailsResponse? userDetails;
  if (user != null) {
    userDetails =  await Injector.firestoreRepository.getUserDetails(null, user.email.toString());
  }
  bool firstLaunch = await SecureStorage.instance.isFirstLaunch();
  bool isCelsius = await SecureStorage.instance.getStoredTempUnit();

  runApp(MyApp(firstLaunch: firstLaunch, isCelsius: isCelsius, userDetails: userDetails));
}

class MyApp extends StatefulWidget {
  final bool firstLaunch;
  final bool isCelsius;
  final UserDetailsResponse? userDetails;

  const MyApp({
    required this.firstLaunch, required this.isCelsius, this.userDetails,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: Injector.providers,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "WeatherNOW",
            theme: AppTheme.primary,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (Provider.of<CommonObjects>(context).firstLaunch == null) Provider.of<CommonObjects>(context).firstLaunch = widget.firstLaunch;
                    if (Provider.of<CommonObjects>(context).userDetails == null) Provider.of<CommonObjects>(context).userDetails = widget.userDetails;
                    if (Provider.of<CommonObjects>(context).isCelsius == null) Provider.of<CommonObjects>(context).isCelsius = widget.isCelsius;
                    return const Dashboard();
                  } else {
                    return const Login();
                  }
                }
           )
        )
    );
  }
}
