import 'package:flutter/material.dart';

class RegistrerScreen extends StatefulWidget {
  const RegistrerScreen({super.key});

  @override
  State<RegistrerScreen> createState() => _RegistrerScreenState();
}

class _RegistrerScreenState extends State<RegistrerScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isObscure = true;

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
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    hintText: 'Correo',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Correo Requerido';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
