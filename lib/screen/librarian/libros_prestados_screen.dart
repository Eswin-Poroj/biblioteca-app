import 'package:biblioteca/widgets/drawer_bibliotecario.dart';
import 'package:flutter/material.dart';

import '../../services/librarian_services.dart';

class LibrosPrestadosScreen extends StatefulWidget {
  const LibrosPrestadosScreen({super.key});

  @override
  State<LibrosPrestadosScreen> createState() => _LibrosPrestadosScreenState();
}

class _LibrosPrestadosScreenState extends State<LibrosPrestadosScreen> {
  List<Map<String, dynamic>> solicitudes = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getSolicitudes();
  }

  Future<void> getSolicitudes() async {
    try {
      setState(() {
        isLoaded = true;
      });
      final libros = await LibrarianServices().allLibrosPrestados();
      setState(() {
        solicitudes = libros;
        isLoaded = false;
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros Prestados'),
      ),
      drawer: drawerBibliotecario(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: isLoaded
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : solicitudes.isEmpty
                      ? const Center(
                          child: Text(
                            'NO HAY SOLICITUDES DE LIBROS PRESTADOS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: solicitudes.length,
                          itemBuilder: (context, index) {
                            final solicitud = solicitudes[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  '${solicitud['ejemplarId']['librod']['nombre']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Nombre del Solicitante: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['perfilId']['nombres']}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Rol: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['perfilId']['rol']['descripcion']}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Estado: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['estadoId']['descripcion']}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Fecha de la Solicitud: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['fechaEntrega']}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Fecha de la Entrega: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['fechaRecepcion']}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Fecha de la Entrega Máxima: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${solicitud['fechaRecepcionMax']}',
                                        ),
                                      ],
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
      ),
    );
  }
}
