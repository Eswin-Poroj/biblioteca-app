import 'package:biblioteca/screen/login_registrer/registrer/registrer_screen.dart';
import 'package:biblioteca/utils/graddient_screen.dart';
import 'package:go_router/go_router.dart';

import '../screen/login_registrer/login_screen.dart';

final routes = {
  GoRoute(
    path: '/',
    builder: (context, state) => const GradientScaffold(
      child: LoginScreen(),
    ),
  ),
  GoRoute(
    path: '/registrer',
    builder: (context, state) => const GradientScaffold(
      child: RegistrerScreen(),
    ),
  ),
};
