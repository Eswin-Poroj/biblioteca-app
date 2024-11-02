import 'package:biblioteca/utils/scaffold_menseger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/user_provider.dart';

class RegistrerScreen extends StatefulWidget {
  const RegistrerScreen({super.key});

  @override
  State<RegistrerScreen> createState() => _RegistrerScreenState();
}

class _RegistrerScreenState extends State<RegistrerScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isObscure = true;
  bool isObscure2 = true;
  String? errorTextForm;

  Future<void> registrerUser() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password == confirmPassword) {
      final response = await context
          .read<UserProvider>()
          .registrarUsuarioProvider(email, password);

      dynamic idUser = response['id'];

      final User user = User(
        email: email,
        password: password,
        id: idUser,
      );
      mensaje(context, '¡Usuario Registrado Correctamente!');
      context.go('/update-user', extra: user);
    } else {
      mensaje(context, '¡Las Contraseñas No Coinciden!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _keyForm,
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_2_sharp,
                        color: Colors.white,
                      ),
                      labelText: 'Correo Electronico',
                      errorText: errorTextForm,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Correo Requerido';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelText: '* * * * * * * *',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      errorText: errorTextForm,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contraseña Requerida';
                      }
                      return null;
                    },
                    obscureText: isObscure,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelText: 'Confirmar Contraseña',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure2 = !isObscure2;
                          });
                        },
                        icon: Icon(
                          isObscure2 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      errorText: errorTextForm,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contraseña Requerida';
                      }
                      return null;
                    },
                    obscureText: isObscure2,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        _keyForm.currentState!.save();
                        registrerUser();
                      }
                    },
                    child: const Text('REGISTRARSE'),
                  ),
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿Ya Tienes Una Cuenta?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/'),
                        child: const Text(
                          'Inicia Sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
