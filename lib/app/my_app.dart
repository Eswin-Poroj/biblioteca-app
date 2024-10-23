import 'package:biblioteca/models/user_provider.dart';
import 'package:biblioteca/utils/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../routes/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _goRoute = GoRouter(
    initialLocation: '/',
    routes: routes.toList(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: themeApp(),
        debugShowCheckedModeBanner: false,
        routerConfig: _goRoute,
      ),
    );
  }
}
