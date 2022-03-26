import 'package:chat/domain/login_provider.dart';
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
                style: TextStyle(
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
                  style: TextStyle(
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

  void handleLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Provider.of<LoginProvider>(context, listen: false)
        .login(_emailController.text, _passwordController.text)
        .then((user) {
      Navigator.of(context).popAndPushNamed(ChatsPage.route);
    }).catchError((error) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Material(
            child: Center(
              child: Container(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    Text(
                      'Sie konnten nicht eingeloggt werden',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
    _passwordController.clear();
    _emailController.clear();
  }

  void handleSignup(BuildContext context) {}
}
