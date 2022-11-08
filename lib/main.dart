import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hf/extensions/extension_theme.dart';
import 'package:flutter_hf/injector.dart';
import 'package:flutter_hf/observer.dart';
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
          title: "Weather HW",
          theme: AppTheme.primary,
         // home: const Dashboard(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,



          home:  StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Dashboard();
                } else {
                  return Login();
                }
              })







    )
    );
  }
}