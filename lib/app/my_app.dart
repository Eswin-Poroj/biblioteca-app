import 'package:biblioteca/utils/theme_app.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      theme: themeApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
