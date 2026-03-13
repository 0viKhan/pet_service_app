import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_constants.dart';

class AuthService {
  Future<void> logout({
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.logout),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final decodedBody = jsonDecode(response.body);

      if (response.statusCode == 200  && decodedBody['success'] == true) {
        return;
      }

      throw Exception(decodedBody['message'] ?? 'Logout failed');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}