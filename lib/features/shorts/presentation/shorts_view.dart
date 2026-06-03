import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/widget/player_widget.dart';
import 'package:social_media/features/feed/presentation/feed.dart';
import 'package:social_media/features/shorts/bloc/shorts_bloc.dart';

class ShortsView extends StatefulWidget {
  const ShortsView({super.key});

  @override
  State<StatefulWidget> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  final List<String> videos = [
    '/data/user/0/com.example.social_media/app_flutter/posts/media/1779650604613_video1.mp4',
    '/data/user/0/com.example.social_media/app_flutter/posts/media/1780041335135_video2.mp4',
    '/data/user/0/com.example.social_media/app_flutter/posts/media/1780041318377_video3.webm',
    '/data/user/0/com.example.social_media/app_flutter/posts/media/1780041354186_video4.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShortsBloc, ShortsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white38,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Feed()));
              } else if (index == 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ShortsView()));
              }
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.play_rectangle), label: ""),
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return ReelsVideoPlayer(assetPath: videos[index]);
                  },
                ),

                Positioned(
                  left: 5,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Feed()));
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),

                // like share and comments
                Positioned(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  right: 10,
                  bottom: 50,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      InkWell(
                        // onTap: () {
                        //   bool val = !post.isLike;
                        //   context.read<FeedBloc>().add(postLikeEvent(id: post.id, isLike: val));
                        // },
                        child: Column(
                          children: [
                            true ? Icon(CupertinoIcons.heart_fill, color: Colors.red) : Icon(CupertinoIcons.heart),
                            SizedBox(width: 5),
                            Text("9", style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [Icon(CupertinoIcons.chat_bubble), SizedBox(width: 5), Text("9", style: TextStyle(fontWeight: FontWeight.w600))],
                        ),
                      ),
                      Column(children: [Icon(CupertinoIcons.share), SizedBox(width: 5), Text("9", style: TextStyle(fontWeight: FontWeight.w600))]),
                      Column(
                        children: [
                          Transform.rotate(angle: -120, child: Icon(Icons.send)),
                          SizedBox(width: 5),
                          Text("9", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
