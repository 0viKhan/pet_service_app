import 'dart:convert';
import 'package:http/http.dart' as http;

class PetService {

  Future<List<dynamic>> getPets(String token) async {

    final response = await http.get(
      Uri.parse('http://23.239.111.164:5022/api/v1/pets'),
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