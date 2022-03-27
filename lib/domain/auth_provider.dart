
import 'dart:convert';

import 'package:chat/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {

  String _baseURL = "https://identitytoolkit.googleapis.com/v1/";
  String _loginURL = "accounts:signInWithPassword";
  String _signUpURL = "accounts:signUp";
  String _apiKey = "KEY";

  User? _user;

  User? get user => _user;

  Future<User> login(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(
          '$_baseURL$_loginURL?key=$_apiKey'),
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

  Future<User> signup(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(
          '$_baseURL$_signUpURL?key=$_apiKey'),
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
}