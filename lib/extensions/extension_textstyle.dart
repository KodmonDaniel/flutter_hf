import 'package:flutter/material.dart';
import 'package:flutter_hf/extensions/extension_colors.dart';

extension AppTextStyle on ThemeData {

  /// Text style extension
  static TextStyle primatyText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400
  );

  static TextStyle author = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w600
  );

  static TextStyle mapTemp = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w600
  );

  static TextStyle planeText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w400
  );

  static TextStyle mainText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w600
  );

  static TextStyle descText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w400
  );

  static TextStyle separator = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500
  );

  static TextStyle tabTitle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500
  );

  static TextStyle btnText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500
  );

  static TextStyle miniBtnText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.textPrimaryDarker,
      fontWeight: FontWeight.w600
  );

  static TextStyle miniText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w400
  );

  static TextStyle bigTitle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 48,
      color: AppColors.textBlack,
      fontWeight: FontWeight.w600
  );


  static TextStyle signupAlertText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28,
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500
  );


}