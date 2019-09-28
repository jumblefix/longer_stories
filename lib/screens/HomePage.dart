import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/services/NavigationService.dart';
import 'package:longer_stories/utils/PermissionUtils.dart';
import 'package:longer_stories/utils/UiHelpers.dart';
import 'package:longer_stories/widgets/LSButton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();

    PermissionUtils.checkStoragePermission().then((p) {
      if (p) {
        _navigationService.navigateToReplaced(RoutePaths.Status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('This app require storage permission to list statuses'),
      action: SnackBarAction(
        onPressed: () async {
          bool granted = await PermissionUtils.requestPermission();
          if (granted) {
            _navigationService.navigateToReplaced(RoutePaths.Status);
          }
        },
        label: 'Retry',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.app_name),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppConstants.permission_msg,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Builder(
                builder: (context) => LSButton(
                  onPressed: () async {
                    bool granted = await PermissionUtils.requestPermission();

                    if (granted) {
                      _navigationService.navigateToReplaced(RoutePaths.Status);
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  },
                  text: 'Enable Storage',
                ),
              ),
              UIHelper.verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
