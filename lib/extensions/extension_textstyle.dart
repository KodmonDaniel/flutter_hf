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

  static TextStyle cityText = TextStyle(
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


}