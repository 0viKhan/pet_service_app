import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/api_constants.dart';
import '../model/park_model.dart';

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

  Future<bool> createPark(String parkName,
      String locationName,
      double lat,
      double lng,
      String token,
      File image,) async {
    final url = ApiConstants.createPark;

    debugPrint("PARK API URL: $url");

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers.addAll({
      "Authorization": "Bearer $token",
    });

    /// JSON data
    request.fields['data'] = jsonEncode({
      "parkName": parkName,
      "locationName": locationName,
      "location_lat": lat,
      "location_lng": lng,
    });

    debugPrint("Park Request Data: ${request.fields['data']}");

    /// image
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint("Park Status Code: ${response.statusCode}");
    debugPrint("Park Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create park");
    }
  }
}