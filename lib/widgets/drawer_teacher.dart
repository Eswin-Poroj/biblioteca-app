import 'package:biblioteca/utils/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer drawerTeacher(BuildContext context) {
  return Drawer(
    elevation: 16.0,
    surfaceTintColor: Colors.blue,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Biblioteca UMG',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Libros'),
          onTap: () {
            context.go('/home-teacher-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Grupos'),
          onTap: () {
            context.go('/view-group-teacher-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Estudiantes'),
          onTap: () {
            context.go('/view-students');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Multas'),
          onTap: () {
            context.go('/view-multas-teacher-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Cerrar Sesion'),
          onTap: () {
            LogoutAlert.alerta(context);
          },
        ),
      ],
    ),
  );
}
