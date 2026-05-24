import 'package:hive/hive.dart';
import 'package:social_media/features/create_post/data/hive_model/post_hive_model.dart';

class PostRepository {
  static const _boxName = 'posts';

  // Save post to Hive
  Future<void> savePost({required PostHiveModel post}) async {
    final box = await Hive.openBox<PostHiveModel>(_boxName);
    await box.add(post);
  }

  // Get all saved posts
  Future<List<PostHiveModel>> getAllPosts() async {
    final box = await Hive.openBox<PostHiveModel>(_boxName);
    return box.values.toList();
  }

  // Delete a post
  Future<void> deletePost(int index) async {
    final box = await Hive.openBox<PostHiveModel>(_boxName);
    await box.deleteAt(index);
  }
}
