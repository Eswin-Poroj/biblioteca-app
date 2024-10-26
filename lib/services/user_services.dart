import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserServices {
  static const String url = 'http://192.168.1.7:8080/';

  ///static const String url = 'http://localhost:8080/';

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
        var decodedResponse = jsonDecode(response.body);
        String accessToken = decodedResponse['token'];

        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: accessToken);

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
        print(response.statusCode);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> user) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      print(token);

      final response = await http.post(
        Uri.parse('${url}perfil'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(user),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        /// Guardar el token en el dispositivo

        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<dynamic> obtenerDatosUsuario() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.get(
        Uri.parse('${url}perfil/auth'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
    } catch (e) {
      print(e);
    }
  }
}
