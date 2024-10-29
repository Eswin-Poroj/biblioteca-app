import 'package:biblioteca/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer.dart';

class ViewGroupsScreen extends StatefulWidget {
  const ViewGroupsScreen({super.key});

  @override
  State<ViewGroupsScreen> createState() => _ViewGroupsScreenState();
}

class _ViewGroupsScreenState extends State<ViewGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRUPOS ASIGNADOS'),
      ),
      drawer: drawerApp(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: Provider.of<UserProvider>(context, listen: false)
                .getGroupsStuden(),
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
                          subtitle: Row(
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
                          onTap: () {
                            // context.go('/update-user', state: group[index]);
                          },
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
