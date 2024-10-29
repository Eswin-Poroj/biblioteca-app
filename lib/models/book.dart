import 'package:flutter/foundation.dart';

import '../services/books_services.dart';

class Book {
  int id;
  String nombre;
  dynamic archivo;
  int existencia;
  bool presentacion;
  String autor;
  String fechaPublicacion;
  int noPaginas;
  String isbn;
  dynamic portada;

  Book({
    required this.id,
    required this.nombre,
    required this.archivo,
    required this.existencia,
    required this.presentacion,
    required this.autor,
    required this.fechaPublicacion,
    required this.noPaginas,
    required this.isbn,
    required this.portada,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      nombre: json['nombre'],
      archivo: json['archivo'],
      existencia: json['existencia'],
      presentacion: json['presentacion'],
      autor: json['autor'],
      fechaPublicacion: json['fechaPublicacion'],
      noPaginas: json['noPaginas'],
      isbn: json['isbn'],
      portada: json['portada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'archivo': archivo,
      'existencia': existencia,
      'presentacion': presentacion,
      'autor': autor,
      'fechaPublicacion': fechaPublicacion,
      'noPaginas': noPaginas,
      'isbn': isbn,
      'portada': portada,
    };
  }

  Book copyWith({
    int? id,
    String? nombre,
    dynamic archivo,
    int? existencia,
    bool? presentacion,
    String? autor,
    String? fechaPublicacion,
    int? noPaginas,
    String? isbn,
    dynamic portada,
  }) {
    return Book(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      archivo: archivo ?? this.archivo,
      existencia: existencia ?? this.existencia,
      presentacion: presentacion ?? this.presentacion,
      autor: autor ?? this.autor,
      fechaPublicacion: fechaPublicacion ?? this.fechaPublicacion,
      noPaginas: noPaginas ?? this.noPaginas,
      isbn: isbn ?? this.isbn,
      portada: portada ?? this.portada,
    );
  }
}

class BookProvider extends ChangeNotifier {
  Future<List<Book>> getBooks() async {
    try {
      final response = await BooksServices().getBooks();
      notifyListeners();
      return response;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Book>> searchBook(String query) async {
    try {
      final response = await BooksServices().searchBooks(query);
      notifyListeners();
      return response;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> solicitarLibro(
      Map<String, dynamic> datosLibro) async {
    try {
      final response = await BooksServices().solicitarLibro(datosLibro);
      notifyListeners();
      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
