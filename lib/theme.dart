import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.pinkAccent,
  fontFamily: 'Open Sans',
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    display4: TextStyle(
      fontSize: 24,
      color: Colors.black,
    ),
  ),
  dialogBackgroundColor: Colors.white.withOpacity(0.3),
);
