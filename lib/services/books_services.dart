import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/book.dart';
import 'package:http/http.dart' as http;

class BooksServices {
  static const String url = 'http://192.168.1.7:8080/';

  Future<List<Book>> getBooks() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      List<Book> books = [];

      final response = await http.get(
        Uri.parse('${url}libros'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(Book.fromJson(item));
        }
        return books;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    try {
      final libros = await getBooks();
      if (query.isEmpty) {
        return libros;
      } else {
        return libros.where((libro) {
          return libro.nombre.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Future<void> solicitarLibro() async {
  //   try {
  //     const storage = FlutterSecureStorage();
  //     String? token = await storage.read(key: 'token');

  //   } catch (e) {}
  // }
}
