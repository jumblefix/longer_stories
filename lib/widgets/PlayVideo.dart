import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String filePath;
  final int currentPage;

  const PlayVideo({
    Key key,
    @required this.filePath,
    @required this.currentPage,
  }) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController _controller;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      _controller.value.isPlaying? Screen.keepOn(true): Screen.keepOn(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(children: [
                  Chewie(
                    controller: ChewieController(
                      videoPlayerController: _controller,
                      autoPlay: false,
                      looping: true,
                      showControls: true,
                      allowFullScreen: false,
                      aspectRatio: _controller.value.aspectRatio,
                    ),
                  ),
                ]),
              )
            : Container(),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
