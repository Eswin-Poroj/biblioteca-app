import 'dart:convert';
import 'dart:typed_data';

import 'package:biblioteca/models/book.dart';

import 'package:flutter/material.dart';

class DetailsBookScreenLibrarian extends StatefulWidget {
  final Book book;
  const DetailsBookScreenLibrarian({super.key, required this.book});

  @override
  State<DetailsBookScreenLibrarian> createState() =>
      _DetailsBookScreenLibrarianState();
}

class _DetailsBookScreenLibrarianState
    extends State<DetailsBookScreenLibrarian> {
  @override
  Widget build(BuildContext context) {
    Uint8List portada = base64Decode(widget.book.portada);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.nombre),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(portada),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(flex: 1),
            Text(
              widget.book.nombre,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(flex: 1),
            Row(
              children: [
                const Text(
                  'Autor: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.book.autor,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Fecha De Publicación: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.book.fechaPublicacion,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'No. de Páginas: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.book.noPaginas.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'En Existencia: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.book.existencia} unidades',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
