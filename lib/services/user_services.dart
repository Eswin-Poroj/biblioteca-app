import 'package:http/http.dart' as http;
import 'dart:convert';

class UserServices {
  static const String url = 'http://192.168.1.7:8080/';

  static Future<dynamic> loginUser(String email, String password) async {
    try {
      Map<String, dynamic> user = {
        'usuario': email,
        'contrasenia': password,
      };
      print(user);

      final response = await http.post(
        Uri.parse('${url}auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print(response.body);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
