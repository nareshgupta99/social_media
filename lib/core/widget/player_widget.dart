import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  final String assetPath;
  double aspectRatio;

  PostVideoPlayer({super.key, required this.assetPath, this.aspectRatio = 4 / 5});

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  late VideoPlayerController controller;

  bool isPlaying = true;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.file(File(widget.assetPath))
      ..initialize().then((_) {
        setState(() {});

        controller.setLooping(true);

        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void togglePlay() {
    setState(() {
      isPlaying = !isPlaying;

      isPlaying ? controller.play() : controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlay,

      child: AspectRatio(
        aspectRatio: controller.value.isInitialized ? controller.value.aspectRatio : widget.aspectRatio,
        child: Stack(
          alignment: Alignment.center,

          children: [
            controller.value.isInitialized ? VideoPlayer(controller) : const Center(child: CircularProgressIndicator()),

            if (!isPlaying) const Icon(Icons.play_arrow, size: 60, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// palyer for preview

class PostPreviewVideoPlayer extends StatefulWidget {
  final String assetPath;
  double aspectRatio;

  PostPreviewVideoPlayer({super.key, required this.assetPath, this.aspectRatio = 4 / 5});

  @override
  State<PostPreviewVideoPlayer> createState() => _PostPreviewVideoPlayerState();
}

class _PostPreviewVideoPlayerState extends State<PostPreviewVideoPlayer> {
  late VideoPlayerController controller;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.file(File(widget.assetPath))
      ..initialize().then((_) {
        setState(() {});

        controller.setLooping(true);

        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void togglePlay() {
    setState(() {
      isPlaying = !isPlaying;

      isPlaying ? controller.play() : controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlay,

      child: AspectRatio(
        aspectRatio: controller.value.isInitialized ? controller.value.aspectRatio : widget.aspectRatio,
        child: Stack(
          alignment: Alignment.center,

          children: [
            controller.value.isInitialized ? VideoPlayer(controller) : const Center(child: CircularProgressIndicator()),

            if (!isPlaying) const Icon(Icons.play_arrow, size: 60, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
