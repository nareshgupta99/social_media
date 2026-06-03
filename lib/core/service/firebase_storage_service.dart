import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  Future<String?> uploadVideo(File videoFile) async {
    try {
      // Get original extension
      String extension = path.extension(videoFile.path);

      // Unique filename
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Storage reference
      Reference ref = FirebaseStorage.instance.ref().child("videos").child("$fileName$extension");

      // Upload file
      UploadTask uploadTask = ref.putFile(videoFile);

      // Wait for upload
      TaskSnapshot snapshot = await uploadTask;

      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print(downloadUrl);

      return downloadUrl;
    } catch (e) {f
      print("Upload Error: $e");
      return null;
    }
  }
}
