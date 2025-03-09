import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Replace with your backend URL
  final String baseUrl = 'http://192.168.1.12:3000/api/auth';

  // Method to sign in
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Parse the response body
      return jsonDecode(response.body);
    } else {
      // Handle errors
      throw Exception('Failed to sign in: ${response.statusCode}');
    }
  }
}