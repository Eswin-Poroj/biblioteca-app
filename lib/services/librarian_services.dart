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

      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return jsonDecode(response.body);
      } else {
        print('Response body != 200: ${response.body}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<void> removeBook(String bookName) async {
    // Remove book from the database
  }

  Future<void> updateBook(String bookName) async {
    // Update book in the database
  }
}
