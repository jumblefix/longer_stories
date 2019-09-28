// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:longer_stories/models/GalleryItem.dart';
// import 'package:longer_stories/widgets/PlayVideo.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class AGalleryPage extends StatefulWidget {
//   AGalleryPage({
//     this.loadingChild,
//     this.backgroundDecoration,
//     this.minScale,
//     this.maxScale,
//     @required this.initialIndex,
//     @required this.galleryItems,
//   }) : pageController = PageController(initialPage: initialIndex);

//   final Widget loadingChild;
//   final Decoration backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final int initialIndex;
//   final PageController pageController;
//   final List<GalleryItem> galleryItems;

//   @override
//   State<StatefulWidget> createState() {
//     return _GalleryPageState();
//   }
// }

// class _GalleryPageState extends State<GalleryPage> {
//   int currentIndex;
//   @override
//   void initState() {
//     currentIndex = widget.initialIndex;
//     super.initState();
//   }

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           decoration: widget.backgroundDecoration,
//           constraints: BoxConstraints.expand(
//             height: MediaQuery.of(context).size.height,
//           ),
//           child: Stack(
//             alignment: Alignment.bottomRight,
//             children: <Widget>[
//               PhotoViewGallery.builder(
//                 scrollPhysics: const BouncingScrollPhysics(),
//                 builder: _buildItem,
//                 itemCount: widget.galleryItems.length,
//                 loadingChild: widget.loadingChild,
//                 backgroundDecoration: widget.backgroundDecoration,
//                 pageController: widget.pageController,
//                 onPageChanged: onPageChanged,
//               ),
//               Container(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(
//                   "Image ${currentIndex + 1}",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }

//   PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
//     final GalleryItem item = widget.galleryItems[index];

//     return PhotoViewGalleryPageOptions.customChild(
//       child: Container(
//         width: 500,
//         height: 500,
//         child: Container(
//           child: item.isVideo
//               ? PlayVideo(
//                   filePath: item.resource,
//                 )
//               : Image.file(
//                   File(item.resource),
//                 ),
//           height: 300.0,
//         ),
//       ),
//       childSize: const Size(500, 500),
//       initialScale: PhotoViewComputedScale.contained,
//       minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//       maxScale: PhotoViewComputedScale.contained * 1.1,
//       heroAttributes: PhotoViewHeroAttributes(tag: item.id),
//     );
//   }
// }
