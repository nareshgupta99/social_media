part of 'feed_bloc.dart';

@immutable
sealed class FeedEvent {}

class LoadFeedEvent extends FeedEvent {}

class postLikeEvent extends FeedEvent {
  String id;
  bool isLike;
  postLikeEvent({required this.id, required this.isLike});
}
