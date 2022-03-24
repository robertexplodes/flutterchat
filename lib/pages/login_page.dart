import 'package:chat/domain/login_provider.dart';
import 'package:chat/pages/chats_page.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
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
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextButton(
                  child: const Text('Login'),
                  onPressed: () {
                    handleLogin(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void handleLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Provider.of<LoginProvider>(context, listen: false)
        .login(_emailController.text, _passwordController.text)
        .then((user) {
          Navigator.of(context).popAndPushNamed(ChatsPage.route);
    })
        .catchError((error) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Material(
            child: Container(
              child: Text('Sie konnten nicht eingeloggt werden'),
            ),
          );
        },
      );
    });
    _passwordController.clear();
    _emailController.clear();
  }
}
