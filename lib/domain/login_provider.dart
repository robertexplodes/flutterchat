
import 'dart:convert';

import 'package:chat/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {

  String _baseURL = "https://identitytoolkit.googleapis.com/v1/";
  String _loginURL = "accounts:signInWithPassword";

  User? _user;

  User? get user => _user;

  Future<User> login(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]'),
          body:
          jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          })
      );
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var user = User(data["email"] as String);
      _user = user;
      return user;
    } catch (error) {
      rethrow;
    }
  }

  void logout() {
    _user = null;
  }
}