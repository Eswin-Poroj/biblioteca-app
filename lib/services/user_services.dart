import 'package:http/http.dart' as http;
import 'dart:convert';

class UserServices {
  static const String url = 'http://192.168.1.7:8080/';

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      Map<String, dynamic> user = {
        'usuario': email,
        'contrasenia': password,
      };

      final response = await http.post(
        Uri.parse('${url}auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> registrerUser(
      String email, String password) async {
    try {
      Map<String, dynamic> user = {
        'usuario': email,
        'contrasenia': password,
        'estado': true,
      };

      final response = await http.post(
        Uri.parse(
          '${url}usuario',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> user) async {
    try {
      final response = await http.put(
        Uri.parse('${url}perfil'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
        /// Guardar el token en el dispositivo
        print(response.body);
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
