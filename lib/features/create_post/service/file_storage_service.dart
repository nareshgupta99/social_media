import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  // Returns permanent path after copying
  static Future<String> saveFile(String tempPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final mediaDir = Directory('${appDir.path}/posts/media');

    // Create folder if not exists
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(tempPath)}';
    final permanentPath = '${mediaDir.path}/$fileName';

    // Copy file from temp → permanent
    await File(tempPath).copy(permanentPath);

    return permanentPath;
  }

  // Save multiple files at once
  static Future<List<String>> saveFiles(List<String> tempPaths) async {
    final results = await Future.wait(tempPaths.map((path) => saveFile(path)));
    return results;
  }

  // Delete a file
  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
