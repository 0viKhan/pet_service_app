import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/config/api_constants.dart';

class ParkService {

  Future<List<dynamic>> getParks(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.myParks),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return decoded['data']['data'];
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load parks: $e");
    }
  }
}