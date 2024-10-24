import 'package:biblioteca/screen/home_screen.dart';
import 'package:biblioteca/screen/login_registrer/registrer/registrer_screen.dart';
import 'package:biblioteca/utils/graddient_screen.dart';
import 'package:go_router/go_router.dart';

import '../models/user_provider.dart';
import '../screen/login_registrer/login_screen.dart';
import '../screen/login_registrer/registrer/update_user.dart';

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
  GoRoute(
    path: '/update-user',
    builder: (context, state) {
      final User user = state.extra as User;
      return GradientScaffold(
        child: UpdateUser(user: user),
      );
    },
  ),
  GoRoute(
    path: '/home',
    redirect: (context, state) => '/',
    builder: (context, state) => const GradientScaffold(
      child: HomeScreen(),
    ),
  ),
};
