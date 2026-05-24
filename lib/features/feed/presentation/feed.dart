import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/widget/post_widget.dart';
import 'package:social_media/core/widget/profile_avatar.dart';
import 'package:social_media/features/create_post/bloc/create_post_bloc.dart';
import 'package:social_media/features/create_post/presentation/preview_screen.dart';
import 'package:social_media/features/feed/bloc/feed_bloc.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<StatefulWidget> createState() => FeedStateWidget();
}

class FeedStateWidget extends State<Feed> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(LoadFeedEvent()); // ← load when screen opens
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        return Scaffold(
          // App Bar
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    final bloc = context.read<CreatePostBloc>();
                    bloc.add(PickInitialMedia());
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PreviewScreen()));
                  },
                  child: Icon(CupertinoIcons.add),
                ),
                Text("Catchy"),
                Icon(CupertinoIcons.heart),
              ],
            ),
          ),

          body:
              state is FeedLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is FeedLoaded
                  ? Column(
                    children: [
                      // stories
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: List.generate(4, (index) => ProfileAvatarStories(radius: 40, imageUri: "assets/images/profile.jpg")),
                        ),
                      ),

                      SizedBox(height: 32),
                      state.posts.isNotEmpty
                          ? Expanded(
                            child: ListView.builder(
                              itemCount: state.posts.length,
                              itemBuilder: (contxt, index) {
                                return PostWidget(post: state.posts[index]);
                              },
                            ),
                          )
                          : Center(child: Text('No posts yet', style: TextStyle(color: Colors.white54))),

                      SizedBox(height: 10),
                    ],
                  )
                  : Center(child: Text('No posts yet', style: TextStyle(color: Colors.white54))),
        );
      },
    );
  }
}
