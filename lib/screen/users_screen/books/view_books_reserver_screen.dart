import 'dart:convert';
import 'dart:typed_data';

import 'package:biblioteca/models/book.dart';
import 'package:biblioteca/services/librarian_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/drawer.dart';

class ViewBooksReserverScreen extends StatefulWidget {
  const ViewBooksReserverScreen({super.key});

  @override
  State<ViewBooksReserverScreen> createState() =>
      _ViewBooksReserverScreenState();
}

class _ViewBooksReserverScreenState extends State<ViewBooksReserverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LIBROS RESERVADOS'),
      ),
      drawer: drawerApp(context),
      body: FutureBuilder<dynamic>(
        future:
            Provider.of<BookProvider>(context).obtenerListaLibrosReservados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar los libros'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'NO SE ENCONTRARON LIBROS RESERVADOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              final books = snapshot.data!;
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          Uint8List bytes = base64Decode(
                            books[index]['ejemplarId']['librod']['portada'],
                          );
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Image.memory(
                                bytes,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                books[index]['ejemplarId']['librod']['nombre']
                                    .toString(),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('Fecha de Entrega: '),
                                      Text(
                                        books[index]['fechaEntrega'].toString(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Fecha de Devolución: '),
                                      Text(
                                        books[index]['fechaRecepcion']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          'Fecha de Máxima De Devolución: '),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(books[index]
                                                      ['fechaEntrega']
                                                  .toString())
                                              .add(
                                            const Duration(days: 3),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Estado: '),
                                      Text(
                                        books[index]['estadoId']['descripcion']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      alerta(context, books[index]['id']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  void alerta(BuildContext context, book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Desea eliminar la reserva?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                LibrarianServices().aprobarSolicitudLibros(book, 2);
                context.pop();
                setState(() {
                  GoRouter.of(context).go('/libros-reservados');
                });
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
