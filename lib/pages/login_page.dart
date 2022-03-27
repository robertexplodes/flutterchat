import 'dart:async';

import 'package:chat/domain/auth_provider.dart';
import 'package:chat/pages/chats_page.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        color: whatsappGrey,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: accentGrey,
                ),
                controller: _emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  filled: true,
                  fillColor: darkGrey,
                  hintStyle: const TextStyle(
                    color: accentGrey,
                  ),
                  hintText: 'E-Mail',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  style: const TextStyle(
                    color: accentGrey,
                  ),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: darkGrey,
                    hintStyle: const TextStyle(
                      color: accentGrey,
                    ),
                    hintText: 'Passwort',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              Container(
                width: 200,
                margin: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: accentGrey,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    handleLogin(context);
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryGreen,
                ),
              ),
              Container(
                width: 200,
                margin: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      color: accentGrey,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    handleSignup(context);
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: messageGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> login(String email, String password, BuildContext context) async {
  //   await  Provider.of<AuthProvider>(context, listen: false)
  //       .login(_emailController.text, _passwordController.text);
  //   Navigator.of(context).popAndPushNamed(ChatsPage.route);
  // }

  void handleLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Provider.of<AuthProvider>(context, listen: false)
    //     .login(_emailController.text, _passwordController.text);
    var email = _emailController.text;
    var password = _passwordController.text;

    showAuthProcess(
      email: email,
      password: password,
      onError: "Sie konntent nicht eingeloggt werden.",
      onSuccess: "Login erfolgreich",
      context: context,
      authProcess: Provider.of<AuthProvider>(context, listen: false).login,
    );
    _passwordController.clear();
    _emailController.clear();
  }

  void showAuthProcess(
      {required String email,
      required String password,
      required String onError,
      required String onSuccess,
      required BuildContext context,
      required Future<dynamic> Function(String email, String password)
          authProcess}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: Center(
            child: SizedBox(
              height: 200,
              child: FutureBuilder(
                future: authProcess(email, password),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        Text(
                          onError,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }
                  Timer(const Duration(seconds: 2), () {
                    Navigator.of(context).pop(); // modal bottom sheet
                    Navigator.of(context).popAndPushNamed(ChatsPage.route);
                  });
                  return SizedBox(
                    child: Center(
                      child: Text(
                        onSuccess,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void handleSignup(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var email = _emailController.text;
    var password = _passwordController.text;

    showAuthProcess(
      email: email,
      password: password,
      onError: "Account konnte nicht erstellt werden.",
      onSuccess: "Account erfolgreich erstellt",
      context: context,
      authProcess: Provider.of<AuthProvider>(context, listen: false).signup,
    );

    _passwordController.clear();
    _emailController.clear();
  }
}
