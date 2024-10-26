import 'package:biblioteca/utils/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _goRoute = GoRouter(
    initialLocation: '/',
    routes: routes.toList(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
      routerConfig: _goRoute,
      
    );
  }
}
