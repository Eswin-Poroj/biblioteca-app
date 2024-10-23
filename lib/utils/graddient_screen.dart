import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF59A5FF), Color(0xFF0050FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            //tileMode: TileMode.clamp,
            //transform: GradientRotation(0.5 * 3.14),
          ),
        ),
        child: child,
      ),
    );
  }
}
