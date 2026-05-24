import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/utils/date_time_utils.dart';
import 'package:social_media/core/widget/player_widget.dart';
import 'package:social_media/core/widget/profile_avatar.dart';
import 'package:social_media/features/feed/bloc/feed_bloc.dart';
import 'package:social_media/features/feed/data/models/media_info.dart';
import 'package:social_media/features/feed/data/models/post_model.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // for profile photo and usrname
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(spacing: 7, children: [ProfileAvatar(imageUri: "assets/images/profile.jpg"), Text("nareshgupta08")]),
              TextButton(
                onPressed: () {},

                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  backgroundColor: const Color(0xFF1A1A1A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFF333333))),
                ),

                child: const Text("Follow", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            bool val = !post.isLike;
            context.read<FeedBloc>().add(postLikeEvent(id: post.id, isLike: val));
          },
          child: PostCarousel(media: post.mediaInfo),
        ),
        SizedBox(height: 10),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 20,
            children: [
              InkWell(
                onTap: () {
                  bool val = !post.isLike;
                  context.read<FeedBloc>().add(postLikeEvent(id: post.id, isLike: val));
                },
                child: Row(
                  children: [
                    post.isLike ? Icon(CupertinoIcons.heart_fill, color: Colors.red) : Icon(CupertinoIcons.heart),
                    SizedBox(width: 5),
                    Text("9", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [Icon(CupertinoIcons.chat_bubble), SizedBox(width: 5), Text("9", style: TextStyle(fontWeight: FontWeight.w600))],
                ),
              ),
              Row(children: [Icon(CupertinoIcons.share), SizedBox(width: 5), Text("9", style: TextStyle(fontWeight: FontWeight.w600))]),
              Row(
                children: [
                  Transform.rotate(angle: -120, child: Icon(Icons.send)),
                  SizedBox(width: 5),
                  Text("9", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                child: Text(post.visibility, style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: RichText(
              text: TextSpan(
                children: [TextSpan(text: "nareshgupt08 ", style: TextStyle(fontWeight: FontWeight.w800)), TextSpan(text: post.postText)],
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(DateTimeUtils.formatTimeToDurationString(post.createdAt), style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }
}

class PostCarousel extends StatefulWidget {
  PostCarousel({super.key, required this.media});
  List<MediaInfo> media = [];

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  final PageController _controller = PageController();

  int currentIndex = 0;

  void nextImage() {
    if (currentIndex < widget.media.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousImage() {
    if (currentIndex > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4.5 / 5,

      child: Stack(
        children: [
          /// Images
          PageView.builder(
            controller: _controller,

            itemCount: widget.media.length,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            itemBuilder: (_, index) {
              if (widget.media[index].type == "video") {
                return PostVideoPlayer(assetPath: widget.media[index].url);
              } else {
                return Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(widget.media[index].url)), fit: BoxFit.cover)),
                );
              }
            },
          ),

          /// LEFT BUTTON
          if (currentIndex > 0)
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  onPressed: previousImage,
                  icon: Transform.flip(flipX: true, child: const Icon(Icons.arrow_forward_ios, color: Colors.white)),
                ),
              ),
            ),

          /// RIGHT BUTTON
          if (currentIndex < widget.media.length - 1)
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(onPressed: nextImage, icon: const Icon(Icons.arrow_forward_ios, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}
