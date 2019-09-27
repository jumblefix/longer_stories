import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppConstants.dart';

class StatusListPage extends StatefulWidget {
  StatusListPage({Key key}) : super(key: key);

  _StatusListPageState createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.app_name),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
