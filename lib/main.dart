import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/routes.dart';
import 'package:longer_stories/services/NavigationService.dart';
import 'package:longer_stories/theme.dart';
import 'package:longer_stories/utils/PermissionUtils.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await setupLocator();

  String defaultPath = RoutePaths.Status;

  var granted = await PermissionUtils.checkStoragePermission();

  if (!granted) {
    defaultPath = RoutePaths.Home;
  }

  runApp(
    MyApp(
      defaultPath: defaultPath,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String defaultPath;

  const MyApp({Key key, @required this.defaultPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.app_name,
      theme: appTheme,
      initialRoute: defaultPath,
      onGenerateRoute: Router.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
