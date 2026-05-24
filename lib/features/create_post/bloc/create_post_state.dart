// part of 'create_post_bloc.dart';

// import 'package:social_media/features/create_post/data/post_media.dart';

import 'package:social_media/features/create_post/data/post_media.dart';

class CreatePostState {
  List<PostMedia> medias;

  String? caption;

  String visibility;

  bool loading;

  bool status;

  CreatePostState({this.medias = const [], this.loading = false, this.status = false, this.caption, this.visibility = "Public"});

  CreatePostState copyWith({List<PostMedia>? medias, bool? loading, bool? status, String? caption, String? visibility}) {
    return CreatePostState(
      medias: medias ?? this.medias,

      loading: loading ?? this.loading,

      status: status ?? this.status,

      caption: caption ?? this.caption,

      visibility: visibility ?? this.visibility,
    );
  }
}
