import 'package:biblioteca/utils/graddient_screen.dart';

import '../screen/login_screen.dart';

final routes = {
  '/': (context) => const GradientScaffold(child: LoginScreen()),
};
