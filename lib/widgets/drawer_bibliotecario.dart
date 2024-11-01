import 'package:biblioteca/utils/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer drawerBibliotecario(BuildContext context) {
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
          title: const Text('Agregar Libro'),
          onTap: () {
            context.go('/add-book-screen-librarian');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Libros'),
          onTap: () {
            context.go('/admin-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Grupos'),
          onTap: () {
            context.go('/view-all-group-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Usuarios'),
          onTap: () {
            context.go('/view-all-user-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Solicitudes'),
          onTap: () {
            context.go('/solicitudes-aprobar-libros-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Prestamos'),
          onTap: () {
            context.go('/libros-prestados-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Ver Multas'),
          onTap: () {},
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
