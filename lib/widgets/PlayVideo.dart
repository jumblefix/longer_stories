import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String filePath;

  const PlayVideo({Key key, @required this.filePath}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
        Screen.keepOn(true);
      });

    _controller.addListener(() {
      if (!_controller.value.isPlaying) Screen.keepOn(false);
    });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(children: [
                  VideoPlayer(_controller),
                  Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      child: _buildPlayPause(),
                      opacity: 0.5,
                    ),
                  ),
                ]),
              )
            : Container(),
      ),
    );
  }

  Widget _buildPlayPause() {
    if (!_controller.value.isPlaying) {
      return Icon(
        Icons.play_arrow,
        size: 50,
        color: Colors.white,
      );
    }
    return Icon(
      Icons.pause,
      size: 50,
      color: Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
