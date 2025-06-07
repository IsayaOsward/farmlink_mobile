import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    HttpOverrides.global = MyHttpOverrides();
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controller.value.isInitialized) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Text(_controller.value.isPlaying ? "Pause" : "Play"),
                ),
              ],
            );
          } else {
            return const Text("Error: Video failed to initialize");
          }
        } else if (snapshot.hasError) {
          return Text("Error loading video: ${snapshot.error}");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
