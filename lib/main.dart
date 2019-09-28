import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/routes.dart';
import 'package:longer_stories/services/NavigationService.dart';
import 'package:longer_stories/theme.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.app_name,
      theme: appTheme,
      initialRoute: RoutePaths.Home,
      onGenerateRoute: Router.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
