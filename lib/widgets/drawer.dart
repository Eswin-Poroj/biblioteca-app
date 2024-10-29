import 'package:flutter/material.dart';

Drawer drawerApp() {
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
          onTap: () {},
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
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.group,
            color: Colors.blue,
          ),
          title: const Text('Visualización De Grupos'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.blue,
          ),
          title: const Text('Perfil'),
          onTap: () {},
        ),
      ],
    ),
  );
}
