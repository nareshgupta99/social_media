import 'package:hive/hive.dart';

part 'post_media_hive.g.dart';

@HiveType(typeId: 1)
class PostMediaHive extends HiveObject {
  @HiveField(0)
  String path;

  @HiveField(1)
  String mediaType;

  @HiveField(2)
  String? thumbnailPath;

  PostMediaHive({required this.path, required this.mediaType, this.thumbnailPath});
}
