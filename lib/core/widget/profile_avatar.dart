import 'package:flutter/material.dart';

class ProfileAvatarStories extends StatefulWidget {
  ProfileAvatarStories({super.key, this.radius = 35, required this.imageUri, this.isStoriesWatched = false});
  double radius;
  String imageUri;
  bool isStoriesWatched;
  @override
  State<StatefulWidget> createState() => _ProfileAvatarStoriesState();
}

class _ProfileAvatarStoriesState extends State<ProfileAvatarStories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.isStoriesWatched ? Colors.grey.shade400 : null,
        gradient:
            widget.isStoriesWatched
                ? null
                : LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.pink, Colors.orange]),
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: CircleAvatar(radius: widget.radius, backgroundImage: AssetImage(widget.imageUri)),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  double radius;
  String imageUri;
  ProfileAvatar({super.key, this.radius = 20, required this.imageUri});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: radius, backgroundImage: AssetImage(imageUri));
  }
}
