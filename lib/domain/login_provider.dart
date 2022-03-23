
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {

  final storage = const FlutterSecureStorage();
  final String _baseURL = 'https://identitytoolkit.googleapis.com/v1/';
  final String _loginURL = 'accounts:signInWithPassword';
  // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC_slH-xMuJHpfhjOCG6q8lCDoBdPZyAXI

  Future<String> loadToken() async {
    return "";
  }

  Future<void> login(String email, String password) async {
    var response = await http.post(
        Uri.parse('$_baseURL/$_loginURL?key=\$API_KEY'));

    throw UnsupportedError('Not implemented');
  }

}