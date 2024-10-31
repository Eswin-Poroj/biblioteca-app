import 'dart:convert';
import 'dart:io';

import 'package:biblioteca/models/add_book.dart';
import 'package:biblioteca/services/librarian_services.dart';
import 'package:biblioteca/widgets/drawer_bibliotecario.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../utils/scaffold_menseger.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _keyTextFieldEditing = GlobalKey<FormState>();
  TextEditingController nombreLibroController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController cantidadExistenciaController = TextEditingController();
  TextEditingController cantidadPaginasController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  String? _errorTextFormField;
  DateTime? _selectedDate;
  File? _image;
  String imagen64 = '';

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
    }
  }

  void capturarImagen(bool tipo) async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile = await picker.pickImage(
        source: tipo ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          final imagen = File(_image!.path).readAsBytesSync();
          imagen64 = base64Encode(imagen);
        } else {
          mensaje(context, 'No Seleccionaste Ninguna Imagen');
        }
      });
      return;
    } catch (e) {
      mensaje(context, 'Error al capturar la imagen');
    }
  }

  void agregarLibro() async {
    final AddBook datosLibro = AddBook(
      nombre: nombreLibroController.text,
      archivo: null,
      portada: imagen64,
      existencia: int.parse(cantidadExistenciaController.text),
      presentacion: 1,
      autor: autorController.text,
      fechaPublicacion: DateFormat('yyyy-MM-dd').format(_selectedDate!),
      noPaginas: int.parse(cantidadPaginasController.text),
      isbn: isbnController.text,
    );
    print(datosLibro.toJson());

    final response = await LibrarianServices().addBook(datosLibro);

    if (response['id'] != null) {
      mensaje(context, 'Libro Agregado Correctamente');
      context.go('/admin-screen');
    } else {
      mensaje(context, 'Error al agregar el libro');
      return;
    }
  }

  void alerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text(
              '¿Estás Seguro De Guardar El Libro?',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Una vez guardado el libro no se podrá modificar la información',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Nombre del libro: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(nombreLibroController.text),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Autor: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(autorController.text),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Cantidad de Existencia: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(cantidadExistenciaController.text),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Fecha de Publicación: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Cantidad de Páginas: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(cantidadPaginasController.text),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'ISBN: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(isbnController.text),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Portada del libro: '),
                const SizedBox(height: 10),
                _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      )
                    : const Text('No se seleccionó ninguna imagen'),
                const SizedBox(height: 10),
                const Text(
                  '¿Deseas Continuar?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  agregarLibro();
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      },
    );
  }

  ///DateFormat('yyyy-MM-dd').format(DateTime.now()).

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGREGAR LIBRO'),
      ),
      drawer: drawerBibliotecario(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _keyTextFieldEditing,
            child: Column(
              children: [
                TextFormField(
                  controller: nombreLibroController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 30,
                    ),
                    labelText: 'Nombre del libro',
                    errorText: _errorTextFormField,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este Campo Es Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: autorController,
                  decoration: InputDecoration(
                    labelText: 'Autor',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                    errorText: _errorTextFormField,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este Campo Es Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cantidadExistenciaController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad de Existencia',
                    prefixIcon: const Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 30,
                    ),
                    errorText: _errorTextFormField,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este Campo Es Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            _selectedDate == null
                                ? 'Fecha de publicación'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            //textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cantidadPaginasController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad de Páginas',
                    prefixIcon: const Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 30,
                    ),
                    errorText: _errorTextFormField,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este Campo Es Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: isbnController,
                  decoration: InputDecoration(
                    labelText: 'ISBN',
                    prefixIcon: const Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 30,
                    ),
                    errorText: _errorTextFormField,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este Campo Es Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Portada del libro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        capturarImagen(false);
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () {
                        capturarImagen(true);
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.contain,
                        )
                      : const Center(
                          child: Text(
                            'AGREGAR PORTADA DEL LIBRO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_keyTextFieldEditing.currentState!.validate()) {
                      _keyTextFieldEditing.currentState!.save();
                      if (_selectedDate == null) {
                        mensaje(context, 'Selecciona Una Fecha De Publicación');
                        return;
                      } else if (_image == null) {
                        mensaje(context, 'Selecciona Una Imagen');
                        return;
                      } else {
                        alerta(context);
                      }
                    }
                  },
                  child: const Text('AGREGAR LIBRO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
