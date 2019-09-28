import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:longer_stories/constants/RoutePaths.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/models/GalleryPageArguments.dart';
import 'package:longer_stories/services/NavigationService.dart';
import 'package:longer_stories/widgets/Thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:path/path.dart' as p;

class StatusListPage extends StatefulWidget {
  StatusListPage({Key key}) : super(key: key);

  _StatusListPageState createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  List<String> mediaList;
  Future<List<String>> _whatsAppStatusMessages;

  @override
  void initState() {
    super.initState();
    _whatsAppStatusMessages = _listWhatsAppStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppConstants.app_name),
            Text(
              'Available Status Messages on your phone',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _whatsAppStatusMessages,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<String>> snapshot,
          ) {
            if (snapshot.hasError) {
              print(snapshot.error);
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  String item = snapshot.data[index];
                  if (item.endsWith('.jpg')) {
                    return Thumbnail(
                      galleryItem: GalleryItem(
                        id: _getFileName(item),
                        resource: item,
                        isVideo: false,
                      ),
                      onPressed: () => _navigate(index),
                    );
                  } else if (item.endsWith('.mp4')) {
                    return FutureBuilder(
                      future: _getImage(item),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Thumbnail(
                            galleryItem: GalleryItem(
                              id: _getFileName(
                                snapshot.data,
                              ),
                              resource: snapshot.data,
                              isVideo: true,
                            ),
                            onPressed: () => _navigate(index),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  }
                  return Text(
                    item,
                    style: TextStyle(color: Colors.black),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text('No status available'),
            );
          }),
    );
  }

  Future<List<String>> _listWhatsAppStatuses() async {
    final Directory w =
        Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

    mediaList = w
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".jpg") || item.endsWith('.mp4'))
        .toList(growable: false);

    return mediaList.length > 0 ? mediaList : [];
  }

  _getImage(videoPathUrl) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    File file = File(videoPathUrl);
    final folderPath = appDocDir.path;
    String thumbFile = p.basename(file.path);
    // TODO handle mime types
    String thumbPath =
        p.join(folderPath, thumbFile.replaceFirst('.mp4', '.jpg'));
    File thumbFileCreated = File(thumbPath);

    if (await thumbFileCreated.exists()) {
      return thumbPath;
    } else {
      String thumb = await Thumbnails.getThumbnail(
        thumbnailFolder: folderPath,
        videoFile: videoPathUrl,
        imageType: ThumbFormat.JPEG,
        quality: 30,
      );

      return thumb;
    }
  }

  _navigate(i) {
    _navigationService.navigateTo(
      RoutePaths.Gallery,
      arguments: GalleryPageArguments(i, mediaList),
    );
  }

  _getFileName(String item) {
    File file = File(item);
    return p.withoutExtension(file.path);
  }

  void _refresh() {
    setState(() {
      _whatsAppStatusMessages = _listWhatsAppStatuses();
    });
  }
}
