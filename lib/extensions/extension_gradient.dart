import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'extension_colors.dart';

extension AppGradient on Gradient {

  static LinearGradient whiteBlueGrad =  LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.backgroundPrimary,
      AppColors.backgroundSecondary,
    ],
  );

  static LinearGradient blueTealGrad =  LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.tealColor3,
      AppColors.blue2,
    ],
  );

  static LinearGradient blueTealLightGrad =  LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.tealColor4,
      AppColors.backgroundSecondary,
    ],
  );





}