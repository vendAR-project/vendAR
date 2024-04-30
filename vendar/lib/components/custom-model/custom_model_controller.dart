import 'dart:io'; // Required for file operations
import 'package:file_picker/file_picker.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart'; // For authentication
import 'package:googleapis/drive/v3.dart' as drive; // Google Drive API
import 'package:path/path.dart' as path; // For path operations in file handling
import 'dart:convert';
import 'package:flutter/services.dart';

class CustomModelController {
  void addModel(Map<String, dynamic> formData, List<File>? pickedFiles,
      PlatformFile? pickedGlbFile) {
    print('Form Data:');
    formData.forEach((key, value) {
      print('$key: $value');
    });

    print('Picked Images:');
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var file in pickedFiles) {
        print('File name: ${file.path}');
      }
    } else {
      print('No images selected.');
    }

    if (pickedGlbFile != null) {
      print('Picked GLB File: ${pickedGlbFile.path}');
    } else {
      print('No GLB file selected.');
    }
    if (pickedGlbFile != null) {
      uploadFileToDrive(pickedGlbFile.path!, "YourFileNameHere");
    }
  }

  Future<drive.File> uploadFileToDrive(String filePath, String fileName) async {
    var json = await loadJsonFromAssets('assets/creds/credentials.json');

    var client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(json),
        [drive.DriveApi.driveFileScope]);

    var driveApi = drive.DriveApi(client);
    var file = drive.File()..name = fileName;
    var fileStream = File(filePath).openRead();
    var media = drive.Media(fileStream, File(filePath).lengthSync());

    var uploadedFile = await driveApi.files.create(file, uploadMedia: media);
    var printList = await driveApi.files.list();
    print(printList.files);

    return uploadedFile;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
