import 'package:biblioteca/services/librarian_services.dart';
import 'package:biblioteca/widgets/drawer_bibliotecario.dart';
import 'package:flutter/material.dart';

class ViewMultasScreen extends StatefulWidget {
  const ViewMultasScreen({super.key});

  @override
  State<ViewMultasScreen> createState() => _ViewMultasScreenState();
}

class _ViewMultasScreenState extends State<ViewMultasScreen> {
  List<Map<String, dynamic>> multas = [];
  bool isLoading = false;

  Future<void> getMultas() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Map<String, dynamic>> data = await LibrarianServices().getMultas();
      setState(() {
        multas = data;
        isLoading = false;
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getMultas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MULTAS REGISTRADAS'),
      ),
      drawer: drawerBibliotecario(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : multas.isEmpty
                      ? const Center(
                          child: Text(
                            'NO HAY MULTAS REGISTRADAS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: multas.length,
                          itemBuilder: (context, index) {
                            var multa = multas[index];
                            return Card(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'DESCRIPCIÓN: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('${multa['descripcion']}'),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Monto: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('${multa['monto']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Dias Excedidos: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${multa['diasExcedidos']}',
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
