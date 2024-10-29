import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';

class ViewBooksReserverScreen extends StatelessWidget {
  const ViewBooksReserverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros Reservados'),
      ),
      drawer: drawerApp(),
      body: const Center(
        child: Text('Reservar Libro'),
      ),
    );
  }
}
