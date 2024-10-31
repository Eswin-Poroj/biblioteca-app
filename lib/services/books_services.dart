import 'dart:convert';

import 'package:biblioteca/services/user_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/book.dart';
import 'package:http/http.dart' as http;

class BooksServices {
  final String urlApi = UserServices.url;

  Future<List<Book>> getBooks() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      List<Book> books = [];

      final response = await http.get(
        Uri.parse('${urlApi}libros'),
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
        print('Estos son los libros');
        print(books);
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

  Future<Map<String, dynamic>> solicitarLibro(
      Map<String, dynamic> datosLibro) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final response = await http.post(
        Uri.parse('${urlApi}libroUsuarios'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(datosLibro),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future obtenerListaLibrosReservados() async {
    try {
      List libros = [];
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      final dataUser = await UserServices().obtenerDatosUsuario();
      final idUsuario = dataUser['id'];
      print(idUsuario);

      final response = await http.get(
        Uri.parse('${urlApi}libroUsuarios/perfil/$idUsuario'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          libros.add(item);
        }
        print(libros);
        return libros;
      } else {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
