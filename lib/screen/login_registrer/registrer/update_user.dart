import 'package:biblioteca/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/scaffold_menseger.dart';

class UpdateUser extends StatefulWidget {
  final User user;
  const UpdateUser({super.key, required this.user});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  List<String> genero = ['Masculino', 'Femenino'];
  String selectedGenero = 'Masculino';
  int sexo = 0;
  final _keyForm = GlobalKey<FormState>();
  String? errorTextForm;

  Future<void> updateUser() async {
    final nombres = nombresController.text;
    final apellidos = apellidosController.text;
    final direccion = direccionController.text;
    final telefono = telefonoController.text;

    final user = {
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'numeroContacto': telefono,
      'sexo': sexo,
      'codigo_interno': null,
      'rol': 3, // 3 es el rol de Estudiante
      'usuario': widget.user.id,
    };

    final userServices = Provider.of<UserProvider>(context, listen: false);

    final response2 = await userServices.login(
      widget.user.email,
      widget.user.password,
    );

    if (response2['success'] == false) {
      mensaje(context, '${response2['message']}');
    } else {
      mensaje(context, '¡Gracias por Registrarte, Actualiza Tus Datos!');
      final response =
          await context.read<UserProvider>().updateUserProvider(user);

      if (response['perfil']['id'] != null) {
        mensaje(context, '¡Datos Actualizados Correctamente!');
        context.go('/home-screen');
      } else {
        mensaje(context, '¡Error al Actualizar Datos!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/icons/avatar.png',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
                const Text(
                  'REGISTRATE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: nombresController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    labelText: 'Nombres',
                    errorText: errorTextForm,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: apellidosController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    labelText: 'Apellidos',
                    errorText: errorTextForm,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: direccionController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    labelText: 'Direccion',
                    errorText: errorTextForm,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: telefonoController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    labelText: 'Telefono',
                    errorText: errorTextForm,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<String>(
                  dropdownColor: const Color.fromARGB(255, 53, 43, 182),
                  validator: (value) {
                    if (value == null) {
                      return 'Campo Obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    labelText: 'Genero',
                    errorText: errorTextForm,
                  ),
                  value: selectedGenero,
                  items: genero.map((String value) {
                    return DropdownMenuItem<String>(
                      alignment: Alignment.center,
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedGenero = value!;
                      if (value == 'Femenino') {
                        sexo = 0;
                      } else {
                        sexo = 1;
                      }
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      updateUser();
                    }
                  },
                  child: const Text('GUARDAR DATOS'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
