import 'dart:convert';
import 'dart:io';

import 'package:flickreview/config/cloudinary_config.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static final String _baseUrl =
      'https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload';

  /// Upload single image
  static Future<String> uploadImage(File imageFile) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_baseUrl));

      request.fields['upload_preset'] = CloudinaryConfig.uploadPreset;

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);

        return data['secure_url'];
      } else {
        throw Exception('Cloudinary upload failed: $responseBody');
      }
    } catch (e) {
      throw Exception('Upload image error: $e');
    }
  }

  /// Upload profile image
  static Future<String> uploadProfileImage(File imageFile) async {
    return await uploadImage(imageFile);
  }

  /// Upload multiple images
  static Future<List<String>> uploadMultipleImages(List<File> files) async {
    try {
      List<String> urls = [];

      for (final file in files) {
        final imageUrl = await uploadImage(file);
        urls.add(imageUrl);
      }

      return urls;
    } catch (e) {
      throw Exception('Upload multiple images error: $e');
    }
  }
}
