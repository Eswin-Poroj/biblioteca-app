import 'package:biblioteca/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/user_provider.dart';

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
      setState(() {
        _selectedDate = picked;
      });
      print('${DateFormat('yyyy-MM-dd').format(_selectedDate!)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Libro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Reservar Libro',
            ),
            ElevatedButton(
              onPressed: () async {
                print(widget.book.id);
                await getIdUser();
                print(dataUser);
              },
              child: const Text('dataUser'),
            ),
            Text(
              _selectedDate == null
                  ? 'No date selected!'
                  : 'Selected datev: ${_selectedDate!.toLocal()}'.split(' ')[0],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 80.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Open Calendar Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
