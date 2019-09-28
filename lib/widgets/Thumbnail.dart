import 'dart:io';
import 'package:flutter/material.dart';
import 'package:longer_stories/models/GalleryItem.dart';

class Thumbnail extends StatelessWidget {
  final Function onPressed;
  final GalleryItem galleryItem;

  const Thumbnail({
    Key key,
    @required this.onPressed,
    @required this.galleryItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: galleryItem.id,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.file(
            File(galleryItem.resource),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: galleryItem.isVideo ? 0.5 : 0,
              child: GestureDetector(
                onTap: onPressed,
                child: IconButton(
                  padding: EdgeInsets.all(60),
                  iconSize: 60,
                  icon: Icon(
                    Icons.play_circle_filled,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
