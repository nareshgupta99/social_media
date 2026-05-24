import 'package:file_picker/file_picker.dart';
import 'package:social_media/features/create_post/data/post_media.dart';

class MediaPickerService {
  static List<String> videoFormats = ['mp4', 'mov', 'avi', 'mkv', 'webm', '3gp', 'm4v'];

  static Future<List<PostMedia>> pickMedia() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,

      type: FileType.custom,

      allowedExtensions: [
        // Images
        'jpg',
        'jpeg',
        'png',
        'webp',
        'bmp',
        'heic',

        // Videos
        'mp4',
        'mov',
        'avi',
        'mkv',
        'webm',
        '3gp',
        'm4v',
      ],
    );

    if (result == null) {
      return [];
    }

    return result.files.map((file) {
      final path = file.path!;

      bool isVideo = false;

      for (String ext in videoFormats) {
        if (path.endsWith(ext)) {
          isVideo = true;
          break;
        }
      }
      return PostMedia(path: path, type: isVideo ? MediaType.video : MediaType.image);
    }).toList();
  }
}
