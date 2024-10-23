import 'package:flutter/material.dart';

void mensaje(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje),
    ),
  );
}
