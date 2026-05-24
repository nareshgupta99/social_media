import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/widget/player_widget.dart';
import 'package:social_media/features/create_post/bloc/create_post_bloc.dart';
import 'package:social_media/features/create_post/bloc/create_post_state.dart';
import 'package:social_media/features/create_post/data/post_media.dart';
import 'package:social_media/features/create_post/presentation/add_caption.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {},
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
                    child: Icon(CupertinoIcons.xmark, color: Colors.white, size: 20),
                  ),
                ),
                Text('Preview', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '${_currentIndex + 1}/${state.medias.length}',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          body:
              state.medias.isEmpty
                  ? _buildEmptyState()
                  : PageView.builder(
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
          bottomNavigationBar: state.medias.isNotEmpty ? _buildBottomActions(context, state) : null,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.photo, size: 64, color: Colors.white30),
          SizedBox(height: 16),
          Text('No media selected', style: TextStyle(color: Colors.white70, fontSize: 16)),
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
              height: 450,
              child: AspectRatio(
                aspectRatio: 4 / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      media.type == MediaType.video ? PostPreviewVideoPlayer(assetPath: media.path) : Image.file(File(media.path), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),

        // DELETE BUTTON
        Positioned(
          top: 100,
          right: 20,
          child: GestureDetector(
            onTap: () {
              context.read<CreatePostBloc>().add(RemoveMedia(index));
              if (_currentIndex > 0) {
                _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
              child: Icon(CupertinoIcons.xmark, color: Colors.white, size: 14),
            ),
          ),
        ),

        // SWIPE INDICATORS (for non-video media)
        if (state.medias.length > 1)
          Positioned(
            bottom: 100,
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

  Widget _buildBottomActions(BuildContext context, CreatePostState state) {
    return Container(
      decoration: BoxDecoration(color: Colors.black87, border: Border(top: BorderSide(color: Colors.white10, width: 0.5))),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                icon: CupertinoIcons.add_circled,
                label: 'Add More',
                onTap: () {
                  context.read<CreatePostBloc>().add(AddMedia());
                },
              ),

              _buildActionButtonText(
                icon: CupertinoIcons.arrow_right,
                label: 'Next',
                isHighlighted: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCaption()));
                },
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, bool isHighlighted = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(color: isHighlighted ? Colors.blue : Colors.white10, borderRadius: BorderRadius.circular(8)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: isHighlighted ? Colors.white : Colors.white70, size: 24)]),
      ),
    );
  }

  Widget _buildActionButtonText({required IconData icon, required String label, required VoidCallback onTap, bool isHighlighted = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(color: isHighlighted ? Colors.blue : Colors.white10, borderRadius: BorderRadius.circular(16)),
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Next"), Icon(icon, color: isHighlighted ? Colors.white : Colors.white70, size: 18)],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String label, String? subtitle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white60, size: 18),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        if (subtitle != null) ...[
          SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.white60, fontSize: 10), textAlign: TextAlign.center),
        ],
      ],
    );
  }
}
