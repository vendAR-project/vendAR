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

class ModifyModelController {
  Dio dio = Dio();
  Future<bool> modifyModel(
      Map<String, dynamic> formData,
      List<PlatformFile>? pickedFiles,
      PlatformFile? pickedGlbFile,
      String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await prefs.getString('userToken');

    String url =
        '${Constants.baseUrl}/api/product/id=$productId/title=${formData['name']}';
    print(url);
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        print("Sucessfully modified name");
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }

    url =
        '${Constants.baseUrl}/api/product/id=$productId/desc=${formData['description']}';
    print(url);
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        print("Sucessfully modified description");
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }

    url =
        '${Constants.baseUrl}/api/product/id=$productId/price=${formData['price']}';
    print(url);
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        print("Sucessfully modified price");
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }

    url =
        '${Constants.baseUrl}/api/product/id=$productId/feature=${formData['category']}';
    print(url);
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        print("Sucessfully modified category");
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }

    url =
        '${Constants.baseUrl}/api/product/id=$productId/spu=${formData['marketLink']}';
    print(url);
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        print("Sucessfully modified external url");
      } else {
        throw Exception(
            'Failed to add product: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
    String? glbFileUrl;
    /*if (pickedGlbFile != null) {
      glbFileUrl = await uploadGLBFile(pickedGlbFile.path!, pickedGlbFile.name);
      url = '${Constants.baseUrl}/api/product/id=$productId/spu=${glbFileUrl}';
      print(url);
      try {
        final response = await dio.put(url,
            options: Options(headers: {
              "Authorization": "Bearer ${userToken}",
            }));
        if (response.statusCode == 200) {
          print("Sucessfully modified model url");
          print(glbFileUrl);
        } else {
          throw Exception(
              'Failed to add product: Status code ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to fetch products: $e');
      }
    }

    if (pickedFiles!.isNotEmpty && pickedFiles != null) {
      uploadFilesToDrive(pickedFiles, productId);
    }*/
    return true;
  }

  Future<String?> uploadGLBFile(String filePath, String fileName) async {
    var json = await loadJsonFromAssets('assets/creds/credentials.json');
    var client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(json),
        [drive.DriveApi.driveFileScope]);
    var driveApi = drive.DriveApi(client);
    var file = drive.File()..name = fileName;
    var fileStream = File(filePath).openRead();
    var media = drive.Media(fileStream, File(filePath).lengthSync());

    // Create the file on Google Drive
    var uploadedFile = await driveApi.files
        .create(file, uploadMedia: media, $fields: 'id, webContentLink');

    // Create a public permission for the file
    var permission = drive.Permission()
      ..type = 'anyone'
      ..role = 'reader';
    await driveApi.permissions.create(permission, uploadedFile.id!);

    return uploadedFile.webContentLink;
  }

  Future<List<String?>> uploadFilesToDrive(
      List<PlatformFile> pickedFiles, String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await prefs.getString('userToken');
    var json = await loadJsonFromAssets('assets/creds/credentials.json');
    var client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(json),
        [drive.DriveApi.driveFileScope]);
    var driveApi = drive.DriveApi(client);

    List<String?> downloadLinks = [];

    for (var platformFile in pickedFiles) {
      var file = drive.File()
        ..name = platformFile.name
        ..mimeType = 'image/jpeg'; // Set the MIME type to JPEG

      var fileStream = File(platformFile.path!).openRead();
      var media = drive.Media(fileStream, platformFile.size);

      // Create the file on Google Drive and request 'id, webContentLink' to get the direct download URL
      var uploadedFile = await driveApi.files
          .create(file, uploadMedia: media, $fields: 'id, webContentLink');

      // Create a public permission for the file
      var permission = drive.Permission()
        ..type = 'anyone'
        ..role = 'reader';
      await driveApi.permissions.create(permission, uploadedFile.id!);

      String url =
          '${Constants.baseUrl}/api/product/id=$productId/image=${uploadedFile}';
      print(url);
      try {
        final response = await dio.put(url,
            options: Options(headers: {
              "Authorization": "Bearer ${userToken}",
            }));
        if (response.statusCode == 200) {
          print("Sucessfully added new image");
        } else {
          throw Exception(
              'Failed to add product: Status code ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to fetch products: $e');
      }
      // Collect webContentLink of uploaded file for direct download
      downloadLinks.add(uploadedFile.webContentLink);
    }

    return downloadLinks;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
