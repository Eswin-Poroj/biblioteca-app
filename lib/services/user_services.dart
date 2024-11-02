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
      return {};
    }
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> user) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.post(
        Uri.parse('${url}perfil'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
        /// Guardar el token en el dispositivo

        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
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
      throw Exception('Error: $e');
    }
  }

  Future<void> logout() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future getGroupsStudens() async {
    try {
      final group = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final dataUser = await UserServices().obtenerDatosUsuario();
      final idUsuario = dataUser['id'];

      final response = await http.get(
        Uri.parse('${url}grupos/estudiante/$idUsuario'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        for (var grupo in decodedResponse) {
          group.add(grupo);
        }
        return group;
      } else {
        return response.body;
      }
    } catch (e) {
      return {};
    }
  }

  Future getAllGroupsStudens() async {
    try {
      final group = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.get(
        Uri.parse('${url}grupos'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        for (var grupo in decodedResponse) {
          group.add(grupo);
        }
        return group;
      } else {
        return response.body;
      }
    } catch (e) {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      List<Map<String, dynamic>> users = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.get(Uri.parse('${url}perfil'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        for (var user in decodedResponse) {
          users.add(user);
        }
        return users;
      } else {
        var decodedResponse = jsonDecode(response.body);
        for (var user in decodedResponse) {
          users.add(user);
        }
        return users;
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    try {
      List<Map<String, dynamic>> users = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response =
          await http.get(Uri.parse('${url}perfil/rol/3'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        for (var user in decodedResponse) {
          users.add(user);
        }
        return users;
      } else {
        var decodedResponse = jsonDecode(response.body);
        for (var user in decodedResponse) {
          users.add(user);
        }
        return users;
      }
    } catch (e) {
      return [];
    }
  }
}
