import 'dart:io';

import 'package:flutter/material.dart';
import 'package:longer_stories/locator.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/services/DialogService.dart';
import 'package:longer_stories/services/StorageService.dart';
import 'package:longer_stories/utils/UiHelpers.dart';
import 'package:longer_stories/widgets/ImageWithZoom.dart';
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
  final DialogService _dialogService = locator<DialogService>();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialPage);

    setState(() {
      _currentPage = widget.initialPage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
                        key: Key(item.resource),
                        filePath: item.resource,
                        currentPage: _currentPage)
                    : ImageWithZoom(
                        image: Image.file(
                          File(item.resource),
                        ),
                      );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              }),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('Save and Share'),
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
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
                      _dialogService.showDialog(
                        title: 'Status Message Saved!',
                        description: saved,
                      );
                    },
                  ),
                  FlatButton.icon(
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
