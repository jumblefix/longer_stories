import 'dart:io';

import 'package:flutter/material.dart';
import 'package:longer_stories/models/GalleryItem.dart';
import 'package:longer_stories/widgets/DotsIndicator.dart';
import 'package:longer_stories/widgets/PlayVideo.dart';

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
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: DotsIndicator(
                    controller: _controller,
                    itemCount: widget.galleryItems.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
