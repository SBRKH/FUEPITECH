import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import '../API/API.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email;
  String _password;

  void _setEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  void _setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  Future<void> _loginButtonPressed() async {
    /*final test = await API.post('https://api.sportsnconnect.com/auth/login',
        {'email': _email, 'password': _password});

      print(test['payload']);
      print(test['payload']['access_token']);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  onChanged: (String text) {
                    _setEmail(text);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Email')),
              TextField(
                  onChanged: (String password) {
                    _setPassword(password);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'password')),
              RaisedButton(
                onPressed: () {
                  _loginButtonPressed();
                },
                child:
                    const Text('Se connecter', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
