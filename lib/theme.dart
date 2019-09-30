import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppColors.dart';

final appTheme = ThemeData(
  primarySwatch: AppColors.appMaterialGrey,
  accentColor: AppColors.appMaterialBlue,
  fontFamily: 'Open Sans',
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  dialogBackgroundColor: Colors.white.withOpacity(0.6),
);
