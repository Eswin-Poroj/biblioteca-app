import 'package:biblioteca/widgets/drawer_bibliotecario.dart';
import 'package:flutter/material.dart';

class SolicitudesBookScreen extends StatefulWidget {
  const SolicitudesBookScreen({super.key});

  @override
  State<SolicitudesBookScreen> createState() => _SolicitudesBookScreenState();
}

class _SolicitudesBookScreenState extends State<SolicitudesBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de libros'),
      ),
      drawer: drawerBibliotecario(context),
    );
  }
}
