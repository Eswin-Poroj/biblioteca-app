import 'package:flutter/material.dart';

import '../services/user_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isObscure = true;
  String? errorTextForm;

  void _login() async {
    try {
      final response = await UserServices.loginUser(
        emailController.text,
        passwordController.text,
      );
      print(response);

      if (response != null) {
        Navigator.pushNamed(context, '/home');
      } else {
        print(response);
      }
    } catch (e) {
      print(e);
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
          child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  const Icon(
                    Icons.person_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
                  const Text(
                    'INICIA SESIÓN',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(flex: 1),
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
                  const Spacer(flex: 1),
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
                  const Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        _keyForm.currentState!.save();
                        _login();
                      }
                    },
                    child: const Text('INICIAR SESIÓN'),
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Registrate',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
