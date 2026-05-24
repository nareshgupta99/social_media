import 'package:hive/hive.dart';
import 'package:social_media/features/create_post/data/hive_model/post_media_hive.dart';


part 'post_hive_model.g.dart';

@HiveType(typeId: 0)
class PostHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<PostMediaHive> medias;

  @HiveField(2)
  final String? caption;

  @HiveField(3)
  final String visibility;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  bool isLike;

  PostHiveModel({required this.id, required this.medias, this.caption, required this.visibility, required this.createdAt, this.isLike = false});
}
