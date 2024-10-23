import 'package:biblioteca/services/user_services.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  void login(String email, String password) async {
    try {
      final response = await UserServices.loginUser(
        email,
        password,
      );
      print(response);

      if (response != null) {
        // Navigator.pushNamed(context, '/home');
      } else {
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }

  void registrer(String email, String password) async {
    try {
      final response = await UserServices.registrerUser(
        email,
        password,
      );
      print(response);

      if (response != null) {
        // Navigator.pushNamed(context, '/home');
      } else {
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }
}
