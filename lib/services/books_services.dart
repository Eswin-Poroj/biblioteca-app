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
        var decodedResponse = jsonDecode(response.body);
        for (var item in decodedResponse) {
          books.add(Book.fromJson(item));
        }
        return books;
      } else {
        return [];
      }
    } catch (e) {
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
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
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
        return libros.where((libro) {
          return libro['estadoId']['descripcion'] != 'Inactivo';
        }).toList();
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      return {};
    }
  }
}
