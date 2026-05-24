import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/features/create_post/data/hive_model/post_hive_model.dart';
import 'package:social_media/features/feed/data/models/media_info.dart';
import 'package:social_media/features/feed/data/models/post_model.dart';
import 'package:social_media/features/repository/post_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;

  FeedBloc({PostRepository? postRepository}) : _postRepository = postRepository ?? PostRepository(), super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<postLikeEvent>(_toogleLikePost);
  }

  Future<void> _onLoadFeed(LoadFeedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      final postsData = await _postRepository.getAllPosts();
      List<PostModel> posts =
          postsData
              .map(
                (post) => PostModel(
                  visibility: post.visibility,
                  postText: post.caption??"",
                  id: post.id,
                  isLike: post.isLike,
                  likeCount: 0,
                  createdAt: post.createdAt,
                  mediaInfo: post.medias.map((media) => MediaInfo(thumbnail: media.thumbnailPath, url: media.path, type: media.mediaType)).toList(),
                ),
              )
              .toList();
      emit(FeedLoaded(posts));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _toogleLikePost(postLikeEvent event, Emitter<FeedState> emit) async {
    try {
      final postsData = await _postRepository.getAllPosts();
      PostHiveModel post = postsData.firstWhere((post) => post.id == event.id);
      post.isLike = event.isLike;
      await post.save();

      final updatedPost = await _postRepository.getAllPosts();

      List<PostModel> posts =
          updatedPost
              .map(
                (post) => PostModel(
                  visibility: post.visibility,
                  id: post.id,
                  isLike: post.isLike,
                  likeCount: 0,
                  createdAt: post.createdAt,
                  mediaInfo: post.medias.map((media) => MediaInfo(thumbnail: media.thumbnailPath, url: media.path, type: media.mediaType)).toList(),
                ),
              )
              .toList();
      emit(FeedLoaded(posts));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }
}
