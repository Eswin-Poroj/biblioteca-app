import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/user_provider.dart';

class LogoutAlert {
  static void alerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alerta!'),
          content: const Text('¿Estas Seguro de Cerrar Sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).logout();
                context.go('/');
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
