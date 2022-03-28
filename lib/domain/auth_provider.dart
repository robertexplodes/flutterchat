
import 'dart:convert';
import 'dart:io';

import 'package:chat/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {

  final String _baseURL = "https://identitytoolkit.googleapis.com/v1/";
  final String _loginURL = "accounts:signInWithPassword";
  final String _signUpURL = "accounts:signUp";
  String _apiKey = "[API_KEY]";

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
      if(response.statusCode != 200) {
        throw HttpException(data["error"]["message"]);
      }
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
      if(response.statusCode != 200) {
        throw HttpException(data["error"]["message"]);
      }
      var user = User(data["email"] as String);
      _user = user;
      return user;
    } catch (error) {
      rethrow;
    }
  }
}