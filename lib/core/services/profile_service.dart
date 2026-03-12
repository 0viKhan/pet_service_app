import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_constants.dart';

class ProfileService {
  Future<String?> updateProfileImage({
    required File imageFile,
    required String token,
    required String firstName,
  }) async {
    try {
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstants.updateProfile),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      request.fields['data'] = jsonEncode({
        'firstName': firstName,
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final decodedBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedBody['data']?['profileImage'];
      } else {
        throw Exception(decodedBody['message'] ?? 'Profile update failed');
      }
    } catch (e) {
      throw Exception('Profile image upload failed: $e');
    }
  }
}