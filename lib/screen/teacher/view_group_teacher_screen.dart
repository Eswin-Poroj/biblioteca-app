import 'package:biblioteca/widgets/drawer_teacher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_provider.dart';

class ViewGroupTeacherScreen extends StatefulWidget {
  const ViewGroupTeacherScreen({super.key});

  @override
  State<ViewGroupTeacherScreen> createState() => _ViewGroupTeacherScreenState();
}

class _ViewGroupTeacherScreenState extends State<ViewGroupTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRUPOS DE ESTUDIANTES'),
      ),
      drawer: drawerTeacher(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: Provider.of<UserProvider>(context, listen: false)
                .getAllGroupsStuden(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data ==
                      'Grupos no encontrados para el estudiante' ||
                  snapshot.data == 'Grupos no encontrados para el profesor') {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      'NO SE REGISTRARON GRUPOS ASIGNADOS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                final group = snapshot.data!;
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: group.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text(
                                'Nombre del Profesor: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                group[index]['profesorId']['nombres'],
                                style: const TextStyle(
                                  fontSize: 20,
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
                                    'Código del Grupo: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    group[index]['id'].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Estudiante Asignado: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    group[index]['estudianteId']['nombres'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    group[index]['estudianteId']['apellidos'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
