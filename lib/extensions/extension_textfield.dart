import 'package:flutter/material.dart';

import 'extension_colors.dart';

extension AppTextField on TextField {

  /// Text style extension
  static OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 5,
        color: AppColors.errorRed
      ),
  );

  static OutlineInputBorder normalBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      width: 2,
      color: AppColors.textBlack
    ),
  );

  static OutlineInputBorder disabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      width: 2,
      color: AppColors.lightGrey
    ),
  );


}