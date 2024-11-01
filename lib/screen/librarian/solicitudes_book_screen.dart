import 'package:biblioteca/services/librarian_services.dart';
import 'package:biblioteca/widgets/drawer_bibliotecario.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SolicitudesBookScreen extends StatefulWidget {
  const SolicitudesBookScreen({super.key});

  @override
  State<SolicitudesBookScreen> createState() => _SolicitudesBookScreenState();
}

class _SolicitudesBookScreenState extends State<SolicitudesBookScreen> {
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
      final libros = await LibrarianServices().allSolicitesLibros();
      print(libros);
      setState(() {
        solicitudes = libros.where((libro) {
          return libro['estadoId']['id'] != 2;
        }).toList();

        isLoaded = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de libros'),
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
                            'NO HAY SOLICITUDES DE LIBROS',
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
                            var solicitud = solicitudes[index];
                            return GestureDetector(
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    '${solicitud['ejemplarId']['librod']['nombre']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const Text(
                                        'Fecha de la Solicitud: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${solicitud['fechaEntrega']}',
                                      ),
                                      const Text(
                                        'Fecha de la Entrega: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${solicitud['fechaRecepcion']}',
                                      ),
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          alerta(context, solicitud['id']);
                                        },
                                        icon: const Icon(Icons.check),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          alertaDelete(
                                              context, solicitud['id']);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
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

  void alertaDelete(BuildContext context, int idBook) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar solicitud'),
          content: const Text('¿Está seguro de eliminar la solicitud?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                aprobarSolicitud(idBook, 2);
                context.pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void alerta(BuildContext context, int idBook) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Aprobar solicitud'),
          content: const Text('¿Está seguro de aprobar la solicitud?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                aprobarSolicitud(idBook, 3);
                context.pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void aprobarSolicitud(int idBook, dynamic estadoSolicitud) async {
    try {
      await LibrarianServices().aprobarSolicitudLibros(idBook, estadoSolicitud);
      getSolicitudes();
    } catch (e) {
      print('Error: $e');
    }
  }
}
