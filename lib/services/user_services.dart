import 'package:http/http.dart' as http;
import 'dart:convert';

class UserServices {
  static const String url = 'http://localhost:8080/';

  static Future<dynamic> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('${url}usuario'),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${url}usuario/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      return;
    }
  }
}
