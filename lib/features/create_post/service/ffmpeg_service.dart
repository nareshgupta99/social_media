import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

class FfmpegService {
  // for thumbnail
  static Future<String?> createThumbnail(String videoPath) async {
    final dir = await getTemporaryDirectory();

    final outputPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await FFmpegKit.execute(
      '-i "$videoPath" '
      '-ss 00:00:01 '
      '-vf scale=720:-1 '
      '-frames:v 1 '
      '"$outputPath"',
    );

    if (await File(outputPath).exists()) {
      return outputPath;
    }

    return null;
  }

  // text on images
}
