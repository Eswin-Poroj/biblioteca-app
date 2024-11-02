import 'package:biblioteca/services/librarian_services.dart';
import 'package:flutter/material.dart';

class AddBook {
  int? id;
  String nombre;
  dynamic archivo;
  dynamic portada;
  int existencia;
  int presentacion;
  String autor;
  String fechaPublicacion;
  int noPaginas;
  String isbn;

  AddBook({
    this.id,
    required this.nombre,
    required this.archivo,
    required this.portada,
    required this.existencia,
    required this.presentacion,
    required this.autor,
    required this.fechaPublicacion,
    required this.noPaginas,
    required this.isbn,
  });

  factory AddBook.fromJson(Map<String, dynamic> json) {
    return AddBook(
      id: json['id'],
      nombre: json['nombre'],
      archivo: json['archivo'],
      portada: json['portada'],
      existencia: json['existencia'],
      presentacion: json['presentacion'],
      autor: json['autor'],
      fechaPublicacion: json['fechaPublicacion'],
      noPaginas: json['noPaginas'],
      isbn: json['isbn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'archivo': archivo,
      'portada': portada,
      'existencia': existencia,
      'presentacion': presentacion,
      'autor': autor,
      'fechaPublicacion': fechaPublicacion,
      'noPaginas': noPaginas,
      'isbn': isbn,
    };
  }

  AddBook copyWith({
    int? id,
    String? nombre,
    dynamic archivo,
    dynamic portada,
    int? existencia,
    int? presentacion,
    String? autor,
    String? fechaPublicacion,
    int? noPaginas,
    String? isbn,
  }) {
    return AddBook(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      archivo: archivo ?? this.archivo,
      portada: portada ?? this.portada,
      existencia: existencia ?? this.existencia,
      presentacion: presentacion ?? this.presentacion,
      autor: autor ?? this.autor,
      fechaPublicacion: fechaPublicacion ?? this.fechaPublicacion,
      noPaginas: noPaginas ?? this.noPaginas,
      isbn: isbn ?? this.isbn,
    );
  }
}

class AddBookProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> addBook(AddBook book) async {
    try {
      final response = await LibrarianServices().addBook(book);

      return response;
    } catch (e) {
      return {};
    }
  }
}
