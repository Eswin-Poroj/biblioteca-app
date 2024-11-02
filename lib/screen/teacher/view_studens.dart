import 'package:biblioteca/services/user_services.dart';
import 'package:biblioteca/widgets/drawer_teacher.dart';
import 'package:flutter/material.dart';

class ViewStudens extends StatefulWidget {
  const ViewStudens({super.key});

  @override
  State<ViewStudens> createState() => _ViewStudensScreenState();
}

class _ViewStudensScreenState extends State<ViewStudens> {
  List<Map<String, dynamic>> usuarios = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      setState(() {
        isLoaded = true;
      });
      final users = await UserServices().getStudents();
      setState(() {
        usuarios = users;
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
        title: const Text('TODOS LOS ESTUDIANTES'),
      ),
      drawer: drawerTeacher(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: isLoaded
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : usuarios.isEmpty
                        ? const Center(
                            child: Text(
                              'NO HAY ESTUDIANTES REGISTRADOS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: usuarios.length,
                            itemBuilder: (context, index) {
                              final user = usuarios[index];
                              return Card(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        user['nombres'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        user['apellidos'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Dirección: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            user['direccion'],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Teléfono: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            user['numeroContacto'].toString(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Email: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            user['usuario']['usuario'],
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
                                            user['rol']['descripcion'],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Sexo: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            user['sexo'] ? 'Hombre' : 'Mujer',
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
                                            user['usuario']['estado']
                                                ? 'Activo'
                                                : 'Inactivo',
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
      ),
    );
  }
}
