import 'package:flutter/material.dart';

class ImageWithZoom extends StatelessWidget {
  final Image image;

  const ImageWithZoom({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image,
    );
  }
}
