import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../extensions/extension_textfield.dart';
import 'login_signup_bloc.dart';
import 'login_signup_event.dart';
import 'login_signup_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup (this._bloc, {Key? key}) : super(key: key);
  final LoginSignupBloc _bloc;

  @override
  State<StatefulWidget> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {

  final nameInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final passwordRepeatInputController = TextEditingController();
  final emailInputController = TextEditingController();

  @override
  void dispose() {
    nameInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (_) => widget._bloc,
      child: BlocBuilder<LoginSignupBloc, LoginSignupState>(
        builder: (context, state) {
          print(state.successSignup.toString());
          return Scaffold(
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //const SizedBox(height: 80),

                      Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.bigTitle),

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
                          errorText: (state.isEmptyField) ? "" : (state.isUsernameNotAvailable)
                              ? AppLocalizations.of(context)!.signup_username_not_available : null,
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
                          errorText: (state.isEmptyField) ? "" : (state.isPwdShort)
                              ? AppLocalizations.of(context)!.signup_pwd_short : null,
                          hintStyle: TextStyle(fontSize: 16),
                            border: AppTextField.normalBorder,
                            errorBorder: AppTextField.errorBorder,
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPwdHidden ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.backgroundDark,
                              ), onPressed: () => widget._bloc.add(LoginSignupPwdHiddenEvent())
                            )
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: passwordRepeatInputController,
                        obscureText: true,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        enabled: !state.isLoading,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password_again,
                          hintStyle: TextStyle(fontSize: 16),
                          border: AppTextField.normalBorder,
                          errorBorder: AppTextField.errorBorder,
                          errorText: (state.isEmptyField) ? "" : (state.isPwdMismatch)
                              ? AppLocalizations.of(context)!.signup_pwd_mismatch : null,
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: emailInputController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        enabled: !state.isLoading,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          hintStyle: TextStyle(fontSize: 16),
                          border: AppTextField.normalBorder,
                          errorBorder: AppTextField.errorBorder,
                          errorText: (state.isEmptyField) ? "" : (state.isEmailSyntaxError)
                              ? AppLocalizations.of(context)!.signup_wrong_email : null,
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),

                      const SizedBox(height: 10),

                      ToggleSwitch(
                        minWidth: 100,
                        cornerRadius: 20,
                        activeBgColors: [[AppColors.textPrimary], [AppColors.textPrimary]],
                        activeFgColor: AppColors.backgroundDark,
                        inactiveBgColor: AppColors.lightGrey,
                        inactiveFgColor: AppColors.backgroundDark,
                        fontSize: 16,
                        initialLabelIndex: state.isAdminSet ? 1 : 0,
                        totalSwitches: 2,
                        labels:  [AppLocalizations.of(context)!.signup_basic, AppLocalizations.of(context)!.signup_admin],
                        radiusStyle: true,
                        onToggle: (index) {
                          state.isLoading ? null : widget._bloc.add(LoginSignupRoleSwitchChangeEvent());
                        },
                      ),

                      const SizedBox(height: 50),

                      ElevatedButton(
                          style: ButtonStyle(
                            //backgroundColor: ,
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                  )
                              )
                          ),
                       // icon: (state.isLoading) ? Icon(Icons.lock_clock_outlined) : Icon(Icons.local_atm), //TODO STYLE
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.btnText),
                        ),
                        onPressed: () => (state.isLoading) ? null :
                          widget._bloc.add(LoginSignupSubmitEvent(
                              nameInputController.text.trim(),
                              emailInputController.text.trim(),
                              passwordInputController.text.trim(),
                              passwordRepeatInputController.text.trim(),
                              state.isAdminSet
                          ))
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



