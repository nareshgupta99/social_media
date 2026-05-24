enum MediaType { image, video }

class PostMedia {
  final String path;
  final MediaType type;
  String? thumbnailPath;

  PostMedia({required this.path, required this.type, this.thumbnailPath});
}
