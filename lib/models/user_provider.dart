import 'package:biblioteca/services/user_services.dart';
import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String password;
  final String token;

  User({
    required this.email,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
    };
  }

  User copyWith({
    String? email,
    String? password,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}

class UserProvider extends ChangeNotifier {
  Future<dynamic> login(String email, String password) async {
    try {
      final response = await UserServices().loginUser(
        email,
        password,
      );
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> registrarUsuarioProvider(
      String email, String password) async {
    try {
      final response = await UserServices().registrerUser(
        email,
        password,
      );
      print(response);
      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
