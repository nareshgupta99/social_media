import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:social_media/features/create_post/bloc/create_post_state.dart';
import 'package:social_media/features/create_post/data/hive_model/post_hive_model.dart';
import 'package:social_media/features/create_post/data/hive_model/post_media_hive.dart';
import 'package:social_media/features/create_post/data/post_media.dart';
import 'package:social_media/features/create_post/service/file_storage_service.dart';
import 'package:social_media/features/create_post/service/media_picker_services.dart';
import 'package:social_media/features/repository/post_repository.dart';
import 'package:uuid/uuid.dart';

part 'create_post_event.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostState()) {
    on<PickInitialMedia>(_pickInitial);

    on<AddMedia>(_addMedia);

    on<RemoveMedia>(_removeMedia);

    on<UpdateVisibility>(_updateVisibility);

    on<UpdateCaption>(_updateCaption);

    on<SavePostEvent>(_createPost);
  }

  Future<void> _pickInitial(PickInitialMedia event, Emitter emit) async {
    final picked = await MediaPickerService.pickMedia();
    emit(state.copyWith(medias: picked));
  }

  Future<void> _addMedia(AddMedia event, Emitter emit) async {
    final more = await MediaPickerService.pickMedia();

    emit(state.copyWith(medias: [...state.medias, ...more]));
  }

  void _removeMedia(RemoveMedia event, Emitter emit) {
    final updated = List<PostMedia>.from(state.medias);

    updated.removeAt(event.index);

    emit(state.copyWith(medias: updated));
  }

  void _updateVisibility(UpdateVisibility event, Emitter emit) {
    String visibility = event.visibility;
    emit(state.copyWith(visibility: visibility));
  }

  void _updateCaption(UpdateCaption event, Emitter emit) {
    String caption = event.caption;
    emit(state.copyWith(caption: caption));
  }

  Future<void> _createPost(SavePostEvent event, Emitter<CreatePostState> emit) async {
    emit(state.copyWith(loading: true));
    PostRepository repository = PostRepository();
    const uuid = Uuid();
    final String id = uuid.v8();
    try {
      final List<PostMediaHive> permanentMedias = await Future.wait(
        state.medias.map((media) async {
          final String finalPath = await FileStorageService.saveFile(media.path);
          return PostMediaHive(mediaType: media.type.name, path: finalPath, thumbnailPath: media.thumbnailPath);
        }),
      );
      PostHiveModel post = PostHiveModel(
        id: id,
        medias: permanentMedias,
        visibility: state.visibility,
        createdAt: DateTime.now(),
        caption: state.caption,
      );

      await repository.savePost(post: post);
      emit(state.copyWith(loading: false, status: true));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
