import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';
import 'models/book.dart';
import 'models/user_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BookProvider(),
      ),
    ], child: MyApp()),
  );
}
