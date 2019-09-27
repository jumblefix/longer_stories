import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppConstants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.app_name),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
