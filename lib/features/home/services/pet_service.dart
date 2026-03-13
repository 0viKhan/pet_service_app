import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/core/config/api_constants.dart';

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

}