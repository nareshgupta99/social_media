import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/widget/player_widget.dart';
import 'package:social_media/core/widget/text_editor.dart';
import 'package:social_media/features/create_post/bloc/create_post_bloc.dart';
import 'package:social_media/features/create_post/bloc/create_post_state.dart';
import 'package:social_media/features/create_post/data/post_media.dart';
import 'package:social_media/features/create_post/presentation/visibility_screen.dart';
import 'package:social_media/features/feed/presentation/feed.dart';

class AddCaption extends StatefulWidget {
  const AddCaption({super.key});

  @override
  State<AddCaption> createState() => _AddCaptionState();
}

class _AddCaptionState extends State<AddCaption> {
  late PageController _pageController;
  int _currentIndex = 0;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state.status == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Feed()),
            (route) => false, // false = remove ALL previous routes
          );
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
                    child: Icon(CupertinoIcons.arrow_left, color: Colors.white, size: 20),
                  ),
                ),
                Text('New Post', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                  child: Icon(CupertinoIcons.arrow_left, color: Colors.transparent, size: 20),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: state.medias.length,
                  itemBuilder: (context, index) {
                    final media = state.medias[index];
                    return _buildMediaPreview(context, media, index, state);
                  },
                ),
              ),

              PostEditor(controller: _textController),
              SizedBox(height: 16),
              _buildOptionBar(Icons.person_pin_outlined, "Tag People"),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AudienceScreen()));
                },
                child: _buildOptionBar(Icons.remove_red_eye_outlined, "Visiblity", value: state.visibility),
              ),
              SizedBox(height: 16),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              context.read<CreatePostBloc>().add(UpdateCaption(_textController.text));
              context.read<CreatePostBloc>().add(SavePostEvent());
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Share", style: TextStyle(fontSize: 20))],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionBar(IconData prefixIcon, String label, {String value = ""}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(spacing: 5, children: [Icon(prefixIcon), Text(label)]),
          Row(children: [Text(value), Icon(Icons.arrow_forward_ios)]),
        ],
      ),
    );
  }

  Widget _buildMediaPreview(BuildContext context, PostMedia media, int index, CreatePostState state) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 300,
              child: AspectRatio(
                aspectRatio: 4 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      media.type == MediaType.video ? PostPreviewVideoPlayer(assetPath: media.path) : Image.file(File(media.path), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),

        // SWIPE INDICATORS (for non-video media)
        if (state.medias.length > 1)
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.medias.length,
                (idx) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 3,
                  width: idx == index ? 24 : 6,
                  decoration: BoxDecoration(color: idx == index ? Colors.blue : Colors.white30, borderRadius: BorderRadius.circular(1.5)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
