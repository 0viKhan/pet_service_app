import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class PetService {
  Future<Map<String, dynamic>> createPet({
    required String token,
    required String name,
    required int age,
    required String gender,
    required String about,
    required String animalType,
    required List<File> images,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://23.239.111.164:5022/api/v1/pets/create'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields['data'] = jsonEncode({
      'name': name,
      'age': age,
      'gender': gender,
      'about': about,
      'animalType': animalType,
    });

    for (final file in images) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          file.path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decoded;
    } else {
      throw Exception(decoded['message'] ?? 'Pet create failed');
    }
  }
}