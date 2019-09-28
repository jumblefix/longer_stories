import 'package:flutter/material.dart';

class GalleryItem {
  final String id;
  final String resource;
  final bool isVideo;

  GalleryItem({
    @required this.id,
    @required this.resource,
    this.isVideo = false,
  });
}
