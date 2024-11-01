import 'dart:convert';

import 'package:biblioteca/models/add_book.dart';
import 'package:biblioteca/services/user_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LibrarianServices {
  final String urlApi = UserServices.url;
  Future<Map<String, dynamic>> addBook(AddBook book) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      final response = await http.post(
        Uri.parse('${urlApi}libros'),
        headers: {
          'Content-Type':
              'application/json', // Corregido 'aplication/json' a 'application/json'
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(book.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> allSolicitesLibros() async {
    try {
      List<Map<String, dynamic>> books = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.get(
        Uri.parse('${urlApi}libroUsuarios'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(item);
        }
        return books;
      } else {
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(item);
        }
        return books;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> allLibrosPrestados() async {
    try {
      List<Map<String, dynamic>> books = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.get(
        Uri.parse('${urlApi}libroUsuarios/estado/3'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(item);
        }
        return books;
      } else {
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(item);
        }
        return books;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> aprobarSolicitudLibros(
      int idBook, dynamic estadoSolicitud) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.put(
        Uri.parse(
            '${urlApi}libroUsuarios/$idBook/estado?estado=$estadoSolicitud'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
