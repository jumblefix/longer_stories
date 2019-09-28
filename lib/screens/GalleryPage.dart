import 'dart:io';

import 'package:flutter/material.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/services/StorageService.dart';
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

  final _kArrowColor = Colors.black.withOpacity(0.8);

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Save and Share'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Text('${_currentPage + 1} / ${widget.galleryItems.length}')
        ],
      ),
      body: IconTheme(
        data: IconThemeData(color: _kArrowColor),
        child: Stack(
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
            Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 15,
              child: Builder(
                builder: (BuildContext context) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton.icon(
                      splashColor: Colors.pinkAccent,
                      color: Theme.of(context).accentColor,
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        var saved = await _storageService.saveFile(
                            widget.galleryItems[_currentPage].resource);
                        final s = SnackBar(content: Text('Saved at $saved'));
                        Scaffold.of(context).showSnackBar(s);
                      },
                    ),
                    FlatButton.icon(
                      splashColor: Colors.pinkAccent,
                      color: Theme.of(context).accentColor,
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
      ),
    );
  }
}
