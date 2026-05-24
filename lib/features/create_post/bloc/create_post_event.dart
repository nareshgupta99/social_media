part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

class PickInitialMedia extends CreatePostEvent {}

class AddMedia extends CreatePostEvent {}

class RemoveMedia extends CreatePostEvent {
  final int index;

  RemoveMedia(this.index);
}

class UpdateVisibility extends CreatePostEvent {
  final String visibility;
  UpdateVisibility(this.visibility);
}

class UpdateCaption extends CreatePostEvent {
  final String caption;
  UpdateCaption(this.caption);
}

class SavePostEvent extends CreatePostEvent {}
