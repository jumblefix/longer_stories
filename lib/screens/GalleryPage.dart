import 'dart:io';

import 'package:flutter/material.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/services/StorageService.dart';
import 'package:longer_stories/utils/UiHelpers.dart';
import 'package:longer_stories/widgets/PlayVideo.dart';
import 'package:share_extend/share_extend.dart';

class GalleryPage extends StatefulWidget {
  final int initialPage;
  final List<GalleryItem> galleryItems;

  const GalleryPage({
    Key key,
    @required this.initialPage,
    @required this.galleryItems,
  }) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  PageController _controller;

  final StorageService _storageService = locator<StorageService>();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialPage);

    setState(() {
      _currentPage = widget.initialPage;
    });

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page.toInt();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.galleryItems.length,
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              var item = widget.galleryItems[index];
              return item.isVideo
                  ? PlayVideo(
                      filePath: item.resource,
                    )
                  : Image.file(
                      File(item.resource),
                    );
            },
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('Save and Share'),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Center(
                  child: Text(
                      '${_currentPage + 1} / ${widget.galleryItems.length}'),
                ),
                UIHelper.horizontalSpaceSmall
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (BuildContext context) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    splashColor: Colors.pinkAccent,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      var saved = await _storageService
                          .saveFile(widget.galleryItems[_currentPage].resource);
                      final s = SnackBar(content: Text('Saved at $saved'));
                      Scaffold.of(context).showSnackBar(s);
                    },
                  ),
                  FlatButton.icon(
                    splashColor: Colors.pinkAccent,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Share',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      var g = widget.galleryItems[_currentPage];
                      var item = g.resource;
                      var f = File(item);
                      ShareExtend.share(
                        f.path,
                        g.isVideo ? 'video' : 'image',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
