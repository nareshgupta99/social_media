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

        controller.setLooping(false);

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

// player for reels
class ReelsVideoPlayer extends StatefulWidget {
  final String assetPath;
  double aspectRatio;

  ReelsVideoPlayer({super.key, required this.assetPath, this.aspectRatio = 4 / 5});

  @override
  State<ReelsVideoPlayer> createState() => _ReelsVideoPlayerState();
}

class _ReelsVideoPlayerState extends State<ReelsVideoPlayer> {
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
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (controller.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover, // Reel style
                  child: SizedBox(width: controller.value.size.width, height: controller.value.size.height, child: VideoPlayer(controller)),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),

            if (!isPlaying) const Icon(Icons.play_arrow, size: 60, color: Colors.white),

            /// Bottom seek bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: true, // drag to seek
                padding: EdgeInsets.zero,
                colors: VideoProgressColors(playedColor: Colors.white, bufferedColor: Colors.white24, backgroundColor: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
