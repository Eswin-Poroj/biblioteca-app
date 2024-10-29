import 'dart:convert';
import 'dart:typed_data';

import 'package:biblioteca/models/book.dart';
import 'package:biblioteca/utils/scaffold_menseger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../models/user_provider.dart';

class ReserverBookScreen extends StatefulWidget {
  final Book book;
  const ReserverBookScreen({super.key, required this.book});

  @override
  State<ReserverBookScreen> createState() => _ReserverBookScreenState();
}

class _ReserverBookScreenState extends State<ReserverBookScreen> {
  Map<String, dynamic> dataUser = {};

  Future<void> getIdUser() async {
    final user =
        await Provider.of<UserProvider>(context, listen: false).getDataUser();

    setState(() {
      dataUser = user;
    });
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.utc(2000),
      lastDate: DateTime.utc(2101),
    );
    if (picked != null && picked != _selectedDate) {
      if (picked.isBefore(DateTime.now())) {
        mensaje(
            context, 'No Puedes Seleccionar Una Fecha Igual O Anterior A Hoy');
        return;
      }

      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _reserverBook() async {
    await getIdUser();
    try {
      final datosLibro = {
        "fechaEntrega": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "fechaRecepcion": DateFormat('yyyy-MM-dd').format(_selectedDate!),
        "estadoId": 1,
        "perfilId": dataUser['id'],
        "ejemplarId": widget.book.id,
        "multaId": 0,
        "pago": null,
      };

      final reservarLibro =
          await Provider.of<BookProvider>(context, listen: false)
              .solicitarLibro(datosLibro);
      print(reservarLibro);

      if (reservarLibro.isNotEmpty) {
        mensaje(context, '¡Libro Reservado Con Éxito!');
        GoRouter.of(context).go('/home-screen');
      } else {
        mensaje(context, '¡Error Al Reservar El Libro!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List portada = base64Decode(widget.book.portada);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESERVAR LIBRO'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'PORTADA DEL LIBRO',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.memory(
              portada,
              fit: BoxFit.cover,
            ),
            const Spacer(flex: 1),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.white),
              children: [
                TableRow(
                  children: [
                    const Text(
                      'NOMBRE DEL LIBRO: ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.book.nombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(
                      'NOMBRE DEL AUTOR: ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.book.autor,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10.0),
              ),
              child: const Text(
                'SELECCIONAR FECHA DE ENTREGA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDate == null
                  ? '¡No Hay Fecha De Entrega!'
                  : 'Fecha Seleccionada: ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () {
                if (_selectedDate == null) {
                  mensaje(context, 'Selecciona Una Fecha De Entrega');
                } else {
                  alertaReservar(context);
                }
              },
              child: const Text('RESERVAR LIBRO'),
            ),
          ],
        ),
      ),
    );
  }

  void alertaReservar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '¡Antes De Reservar tu Libro!',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Por Favor Verifica Los Siguientes Datos Antes de Reservar:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Nombre del Libro: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.book.nombre),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Fecha de Reservación: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Fecha de Entrega: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(_selectedDate!).toString(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Fecha de Máxima Entrega (Con Multa): ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy')
                    .format(
                      _selectedDate!.add(
                        const Duration(days: 3),
                      ),
                    )
                    .toString(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _reserverBook();
              },
              child: const Text('Reservar'),
            ),
          ],
        );
      },
    );
  }
}
