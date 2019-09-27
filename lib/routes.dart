import 'package:flutter/material.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/screens/HomePage.dart';
import 'package:longer_stories/screens/StatusListPage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Status:
        return MaterialPageRoute(builder: (_) => StatusListPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
