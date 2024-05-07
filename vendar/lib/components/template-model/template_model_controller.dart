import 'dart:io'; // Required for file operations
import 'package:file_picker/file_picker.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart'; // For authentication
import 'package:googleapis/drive/v3.dart' as drive; // Google Drive API
import 'package:path/path.dart' as path; // For path operations in file handling
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';

class EditModelController {
  Dio dio = Dio();
  Future<bool> addModel(Map<String, dynamic> formData,
      List<PlatformFile>? pickedFiles, String glbFileSrc) async {
    String url = '${Constants.baseUrl}${Constants.addNewProductEndpoint}';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    final Map<String, dynamic> body = {
      "user_id": await prefs.getString("userID"),
      "product_title": formData["title"],
      "product_desc": formData["description"],
      "product_price": formData['price'] ?? "0.0",
      "product_images":
          pickedFiles != null ? await uploadFilesToDrive(pickedFiles) : [""],
      "product_feature": formData["category"] ?? "Other",
      "product_sales_page_url": formData["shopUrl"],
      "product_src": glbFileSrc
    };
    print(body);
    try {
      final response = await dio.post(url,
          data: body,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle possible network errors
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<List<String?>> uploadFilesToDrive(
      List<PlatformFile> pickedFiles) async {
    var json = await loadJsonFromAssets('assets/creds/credentials.json');
    var client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(json),
        [drive.DriveApi.driveFileScope]);
    var driveApi = drive.DriveApi(client);

    List<String?> downloadLinks = [];

    for (var platformFile in pickedFiles) {
      var file = drive.File()
        ..name = platformFile.name
        ..mimeType = 'image/jpeg';

      var fileStream = File(platformFile.path!).openRead();
      var media = drive.Media(fileStream, platformFile.size);

      var uploadedFile = await driveApi.files
          .create(file, uploadMedia: media, $fields: 'id, webContentLink');

      var permission = drive.Permission()
        ..type = 'anyone'
        ..role = 'reader';
      await driveApi.permissions.create(permission, uploadedFile.id!);

      downloadLinks.add(uploadedFile.webContentLink);
    }
    print(downloadLinks);
    return downloadLinks;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
