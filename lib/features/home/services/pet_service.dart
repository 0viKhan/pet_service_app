import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/core/config/api_constants.dart';

import '../../add_animal/model.dart';

class PetService {

  Future<List<dynamic>> getPets(String token) async {
    final response = await http.get(
      Uri.parse(ApiConstants.myPet),

      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return decoded["data"];
    } else {
      throw Exception(decoded["message"]);
    }
  }

  Future<bool> createPet(PetModel pet,
      String token,
      List<File> images,) async {
    final url = ApiConstants.createPet;

    debugPrint("API URL: $url");

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers.addAll({
      "Authorization": "Bearer $token",
    });

    /// JSON body inside "data"
    request.fields['data'] = jsonEncode({
      "name": pet.name,
      "age": pet.age,
      "gender": pet.gender,
      "about": pet.about,
      "animalType": pet.animalType,
    });

    debugPrint("Request data: ${request.fields['data']}");

    /// Images
    for (final image in images) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          image.path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create pet");
    }
  }
}