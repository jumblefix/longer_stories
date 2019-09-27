import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:longer_stories/screens/HomePage.dart';
import 'package:longer_stories/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.app_name,
      theme: appTheme,
      home: HomePage(),
    );
  }
}
