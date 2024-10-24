import 'package:biblioteca/services/user_services.dart';
import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String password;
  final int id;

  User({
    required this.email,
    required this.password,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'id': id,
    };
  }

  User copyWith({
    String? email,
    String? password,
    int? id,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
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

  Future<Map<String, dynamic>> updateUserProvider(
      Map<String, dynamic> user) async {
    try {
      final response = await UserServices().updateUser(user);
      print(response);
      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
