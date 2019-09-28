import 'package:flutter/material.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/models/GalleryPageArguments.dart';
import 'package:longer_stories/screens/GalleryPage.dart';
import 'package:longer_stories/screens/HomePage.dart';
import 'package:longer_stories/screens/StatusListPage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Status:
        return MaterialPageRoute(builder: (_) => StatusListPage());
      case RoutePaths.Gallery:
        final GalleryPageArguments arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => GalleryPage(
            galleryItems: arg.mediaList
                .map(
                  (i) => GalleryItem(
                    id: i,
                    resource: i,
                    isVideo: i.endsWith('.mp4'),
                  ),
                )
                .toList(),
            initialPage: arg.index,
          ),
        );
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
