import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer drawerApp(BuildContext context) {
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
            Icons.home,
            color: Colors.blue,
          ),
          title: const Text('Inicio'),
          onTap: () {
            context.go('/home-screen');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: const Text('Multas'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.shopping_cart,
            color: Colors.blue,
          ),
          title: const Text('Pedidos'),
          onTap: () {
            context.go('/libros-reservados');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.group,
            color: Colors.blue,
          ),
          title: const Text('Visualización De Grupos'),
          onTap: () {
            context.go('/view-groups');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.blue,
          ),
          title: const Text('Perfil'),
          onTap: () {
            context.go('/profile-screen');
          },
        ),
      ],
    ),
  );
}
