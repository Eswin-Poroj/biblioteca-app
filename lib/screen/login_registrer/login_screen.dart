import 'package:biblioteca/models/user_provider.dart';
import 'package:biblioteca/utils/scaffold_menseger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  Future<void> _login() async {
    try {
      final userServices = Provider.of<UserProvider>(context, listen: false);
      final response = await userServices.login(
        emailController.text,
        passwordController.text,
      );
      if (response['success'] == false) {
        mensaje(context, '${response['message']}');
      } else {
        print(response);
        mensaje(context, 'Bienvenido, Acceso Correcto');
        context.go('/home-screen');
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
                  Image.asset(
                    'assets/icons/avatar.png',
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
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
                        onPressed: () => context.go('/registrer'),
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
