import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_gradient.dart';
import 'package:flutter_hf/extensions/extension_textfield.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter_hf/repository/firestore/firestore_repository.dart';
import 'package:jumping_dot/jumping_dot.dart';
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
            //resizeToAvoidBottomPadding:false,
            body: Stack(
              children: <Widget>[

                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background/login_bg.png"),
                          fit: BoxFit.cover
                      )
                  ),
                ),



              /*  Positioned(
                  bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: const BoxDecoration(
                            image:  DecorationImage(
                                image: AssetImage("assets/images/background/login_banner.png"),
                                fit: BoxFit.cover
                            )
                        ))
                    ,
                  ),
                ),



                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background/login_banner.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
*/
              Center(
                child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(AppLocalizations.of(context)!.login, style: AppTextStyle.bigTitle),

                          const SizedBox(height: 60,),

                          TextField(
                            controller: nameInputController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            enabled: !state.isLoading,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.username,
                              hintStyle: TextStyle(fontSize: 16),
                              border: AppTextField.normalBorder,
                              errorBorder: AppTextField.errorBorder,
                              disabledBorder: AppTextField.disabledBorder,
                              errorText: (state.isUsernameError) ? AppLocalizations.of(context)!.login_uname_error : null,
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextField(
                            controller: passwordInputController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            obscureText: state.isPwdHidden,
                            enableSuggestions: false,
                            autocorrect: false,
                            enabled: !state.isLoading,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.password,
                              hintStyle: TextStyle(fontSize: 16),
                              border: AppTextField.normalBorder,
                              errorBorder: AppTextField.errorBorder,
                              disabledBorder: AppTextField.disabledBorder,
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

                         /* Container(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: (state.isLoading) ? AppColors.tealColor4 : AppColors.tealColor3,
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
                                child: (state.isLoading)
                                  ? JumpingDots(
                                    color: AppColors.textWhite,
                                    radius: 5,
                                    numberOfDots: 3,
                                    animationDuration: const Duration(milliseconds: 200))
                                  : Text(AppLocalizations.of(context)!.login, style: AppTextStyle.btnText),
                              ),
                              onPressed: () => (state.isLoading) ? null :
                                Provider.of<LoginBloc>(context, listen: false).add(LoginSubmitEvent(nameInputController.text.trim(), passwordInputController.text.trim()))
                            ),
                          ),*/


                   Container(
                       width: 150,
                       height: 40,
                       decoration: BoxDecoration(gradient: (state.isLoading) ? AppGradient.blueTealLightGrad : AppGradient.blueTealGrad,
                           borderRadius: const BorderRadius.all(Radius.circular(30))
                       ),
                       child: Material(
                         color: Colors.transparent,
                         child: InkWell(
                           customBorder: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(30),
                           ),
                           onTap: () => (state.isLoading) ? null :
                           Provider.of<LoginBloc>(context, listen: false).add(LoginSubmitEvent(nameInputController.text.trim(), passwordInputController.text.trim())),
                           child: Center(
                             child: Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                               child: (state.isLoading)
                                   ? JumpingDots(
                                   color: AppColors.textWhite,
                                   radius: 8,
                                   numberOfDots: 3,
                                   animationDuration: const Duration(milliseconds: 200))
                                   : Text(AppLocalizations.of(context)!.login, style: AppTextStyle.btnText),
                             ),
                           ),
                         ),
                       )),









                          const SizedBox(height: 20),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!.no_account, style: AppTextStyle.miniText),
                                InkWell(
                                  onTap: () {
                                    var loginSignupBloc = LoginSignupBloc(Provider.of<FirestoreRepository>(context, listen: false));
                                    var loginSignup = LoginSignup(loginSignupBloc);
                                    var route = AppRoute.createRoute(loginSignup);
                                    Navigator.of(context).push(route);
                                  },
                                  child: Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.miniBtnText,),//todo
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),













          ]
            ),
          );
        }
      )
    );
  }
}



