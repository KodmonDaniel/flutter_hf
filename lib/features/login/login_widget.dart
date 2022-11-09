import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textfield.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../extensions/extension_route.dart';
import 'login_event.dart';
import 'login_signup/login_signup_bloc.dart';
import 'login_signup/login_signup_widget.dart';
import 'login_state.dart';
import 'login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login ({Key? key});
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final nameInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void dispose() {
    nameInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: Provider.of<LoginBloc>(context),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)!.login, style: AppTextStyle.bigTitle),

                      const SizedBox(height: 50,),

                      TextField(
                        controller: nameInputController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        enabled: !state.isLoading,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.username,
                          hintStyle: TextStyle(fontSize: 16),
                          border: AppTextField.normalBorder,
                          errorBorder: AppTextField.errorBorder,
                          errorText: (state.isUsernameError) ? AppLocalizations.of(context)!.login_uname_error : null,
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: passwordInputController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        obscureText: state.isPwdHidden,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: TextStyle(fontSize: 16),
                          border: AppTextField.normalBorder,
                          errorBorder: AppTextField.errorBorder,
                          filled: true,
                          errorText: (state.isPwdError) ? AppLocalizations.of(context)!.login_pwd_error : null,
                          contentPadding: const EdgeInsets.all(16),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPwdHidden ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.backgroundDark,
                              ), onPressed: () =>
                                Provider.of<LoginBloc>(context, listen: false).add(LoginPwdHiddenEvent())
                            )
                        ),
                      ),

                      const SizedBox(height: 50),

                      ElevatedButton(
                          style: ButtonStyle(
                            //backgroundColor: ,
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      //side: BorderSide(color: Colors.red),
                                  )
                              )
                          ),
                       // icon: (state.isLoading) ? Icon(Icons.lock_clock_outlined) : Icon(Icons.local_atm), //TODO STYLE
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(AppLocalizations.of(context)!.login, style: AppTextStyle.btnText),
                        ),
                        onPressed: () => (state.isLoading) ? null :
                          Provider.of<LoginBloc>(context, listen: false).add(LoginSubmitEvent(nameInputController.text.trim(), passwordInputController.text.trim()))
                      ),









                      const SizedBox(height: 10,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No account yet? '),
                            InkWell(
                              onTap: () {
                                var loginSignupBloc = LoginSignupBloc(Provider.of<FirestoreRepository>(context, listen: false));
                                var loginSignup = LoginSignup(loginSignupBloc);
                                var route = AppRoute.createRoute(loginSignup);
                                Navigator.of(context).push(route);
                              },
                              child: Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.signUp,),//todo
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          );
        }
      )
    );
  }
}



