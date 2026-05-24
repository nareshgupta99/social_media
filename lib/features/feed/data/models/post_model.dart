import 'package:social_media/features/feed/data/models/media_info.dart';

class PostModel {
  String id;
  String postText;
  bool isLike;
  int likeCount;
  DateTime createdAt;
  List<MediaInfo> mediaInfo;
  String visibility;

  PostModel({required this.id, this.postText = "", required this.isLike, required this.likeCount, required this.createdAt, required this.mediaInfo,required this.visibility});
}
