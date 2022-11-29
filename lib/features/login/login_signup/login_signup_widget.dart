import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';
import 'package:flutter_hf/extensions/extension_textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../extensions/extension_gradient.dart';
import '../../../extensions/extension_textfield.dart';
import '../../../preferences/common_objects.dart';
import 'login_signup_bloc.dart';
import 'login_signup_event.dart';
import 'login_signup_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    passwordRepeatInputController.dispose();
    emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (_) => widget._bloc,
        child: BlocBuilder<LoginSignupBloc, LoginSignupState>(
          builder: (context, state) {
            if (state.userDetailsResponse != null) Provider.of<CommonObjects>(context, listen: false).userDetails = state.userDetailsResponse;
            return Scaffold(
                body: Stack(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/background/signup_bg.png"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Padding(
                            padding: (kIsWeb) ? EdgeInsets.symmetric(horizontal: screenWidth/3) : const EdgeInsets.fromLTRB(50, 50, 50, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.bigTitle),
                                  const SizedBox(height: 50,),
                                  _uNameInput(state),
                                  const SizedBox(height: 10),
                                  _pwdInput(state),
                                  const SizedBox(height: 10),
                                  _pwdRepeatInput(state),
                                  const SizedBox(height: 10),
                                 _emailInput(state),
                                  const SizedBox(height: 10),
                                  _roleSwitch(state),
                                  const SizedBox(height: 50),
                                  _signUpBtn(state),
                                  const SizedBox(height: 20),
                                  _backArrow(state),
                                ],
                              ),
                            ),
                        ),
                      ),
                      _successIndicator(state),
                    ]
                )
            );
          })
    );
  }

  _uNameInput(LoginSignupState state) {
    return TextField(
      controller: nameInputController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      enabled: !state.isLoading,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.username,
        hintStyle: AppTextStyle.textStyleField,
        border: AppTextField.normalBorder,
        errorBorder: AppTextField.errorBorder,
        disabledBorder: AppTextField.disabledBorder,
        errorText: (state.isEmptyField && nameInputController.text.isEmpty)
            ? AppLocalizations.of(context)!.signup_fill_field : (state.isUsernameNotAvailable)
            ? AppLocalizations.of(context)!.signup_username_not_available : null,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  _pwdInput(LoginSignupState state) {
    return TextField(
      controller: passwordInputController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      obscureText: state.isPwdHidden,
      enableSuggestions: false,
      autocorrect: false,
      enabled: !state.isLoading,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          errorText: (state.isEmptyField && passwordInputController.text.isEmpty)
              ? AppLocalizations.of(context)!.signup_fill_field : (state.isPwdShort)
              ? AppLocalizations.of(context)!.signup_pwd_short : null,
          hintStyle: AppTextStyle.textStyleField,
          border: AppTextField.normalBorder,
          errorBorder: AppTextField.errorBorder,
          disabledBorder: AppTextField.disabledBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: IconButton(
              icon: Icon(
                state.isPwdHidden ? Icons.visibility : Icons.visibility_off,
                color: AppColors.backgroundDark,
              ), onPressed: () => widget._bloc.add(LoginSignupPwdHiddenEvent())
          )
      ),
    );
  }

  _pwdRepeatInput(LoginSignupState state) {
    return TextField(
      controller: passwordRepeatInputController,
      obscureText: true,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      enabled: !state.isLoading,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.password_again,
        hintStyle: AppTextStyle.textStyleField,
        border: AppTextField.normalBorder,
        errorBorder: AppTextField.errorBorder,
        disabledBorder: AppTextField.disabledBorder,
        errorText: (state.isEmptyField && passwordRepeatInputController.text.isEmpty)
            ? AppLocalizations.of(context)!.signup_fill_field : (state.isPwdMismatch)
            ? AppLocalizations.of(context)!.signup_pwd_mismatch : null,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  _emailInput(LoginSignupState state) {
    return  TextField(
      controller: emailInputController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      enabled: !state.isLoading,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.email,
        hintStyle: AppTextStyle.textStyleField,
        border: AppTextField.normalBorder,
        errorBorder: AppTextField.errorBorder,
        disabledBorder: AppTextField.disabledBorder,
        errorText: (state.isEmptyField && emailInputController.text.isEmpty)
            ? AppLocalizations.of(context)!.signup_fill_field : (state.isEmailSyntaxError)
            ? AppLocalizations.of(context)!.signup_wrong_email : null,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  _roleSwitch(LoginSignupState state) {
    return ToggleSwitch(
      minWidth: 100,
      cornerRadius: 20,
      activeBgColor: [AppColors.tealColor3],
      activeFgColor: AppColors.white,
      inactiveBgColor: AppColors.lightGrey,
      inactiveFgColor: AppColors.backgroundDark,
      fontSize: 16,
      initialLabelIndex: state.isAdminSet ? 1 : 0,
      totalSwitches: 2,
      labels:  [AppLocalizations.of(context)!.basic, AppLocalizations.of(context)!.admin],
      radiusStyle: true,
      onToggle: (index) {
        state.isLoading ? null : widget._bloc.add(LoginSignupRoleSwitchChangeEvent());
      },
    );
  }

  _signUpBtn(LoginSignupState state) {
    return Container(
        width: 160,
        height: 40,
        decoration: BoxDecoration(
            gradient: (state.isLoading)
                ? AppGradient.blueTealLightGrad
                : AppGradient.blueTealGrad,
            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () => (state.isLoading) ? null :
            widget._bloc.add(LoginSignupSubmitEvent(
                nameInputController.text.trim(),
                emailInputController.text.trim(),
                passwordInputController.text.trim(),
                passwordRepeatInputController.text.trim(),
                state.isAdminSet
            )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: (state.isLoading)
                    ? LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.white,
                    size: 40)
                    : Text(AppLocalizations.of(context)!.signup, style: AppTextStyle.btnText),
              ),
            ),
          ),
        )
    );
  }

  _backArrow(LoginSignupState state) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.backgroundDark),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  _successIndicator(LoginSignupState state) {
    return Visibility(
      visible: (state.successSignup != null),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Center(
          child: ClipRect(
              child:  Container(
                width: 300,
                height: 380,
                decoration: BoxDecoration(
                    color: (state.successSignup ?? false)
                        ? AppColors.successGreen.withOpacity(0.7)
                        : AppColors.errorRed.withOpacity(0.7)
                ),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          (state.successSignup ?? false)
                              ? Icon(Icons.check_circle_outline, size: 150, color: AppColors.white,)
                              : Icon(Icons.error_outline, size: 150, color: AppColors.white,),

                          (state.successSignup ?? false)
                              ? Text(AppLocalizations.of(context)!.signup_success, style: AppTextStyle.signupAlertText, textAlign: TextAlign.center)
                              : Text(AppLocalizations.of(context)!.signup_failed, style: AppTextStyle.signupAlertText, textAlign: TextAlign.center),

                          SizedBox(
                            width: 150,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.white, width: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(AppLocalizations.of(context)!.back, style: AppTextStyle.btnText),
                            ),
                          )
                        ],
                      ),
                    )
                ),
              )
          ),
        ),
      ),
    );
  }

}



