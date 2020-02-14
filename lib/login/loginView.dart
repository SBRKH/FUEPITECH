import 'package:fuepitech/validator/validator.dart';
import 'package:flutter/material.dart';
import '../API/API.dart';
import '../API/Routes.dart';
import '../signup.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email;
  String _password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    final Map<String, dynamic> body = Map<String, dynamic>();

    body['email'] = _email;
    body['password'] = _password;
    final dynamic test = await API.post(Routes.LOGIN, body);
    print(test['payload']['user_id']);
    print(test['payload']['access_token']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Form(
                  key: formKey,
                  child: Wrap(
                    runSpacing: 5,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TextFormField(
                                onChanged: (String email) {
                                  _setEmail(email);
                                },
                                validator:
                                    composeValidator([isEmpty(), isEmail()]),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(53, 59, 72, 1))),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TextFormField(
                                onChanged: (String password) {
                                  _setPassword(password);
                                },
                                obscureText: true,
                                validator: isEmpty(),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'MOT DE PASSE',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(53, 59, 72, 1))),
                              ),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: FlatButton(
                                child: const Text('Se connecter'),
                                onPressed: () {
                                  _loginButtonPressed();
                                },
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: FlatButton(
                                  child: const Text(
                                      'Pas de compte ? Inscrivez-vous.'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signUp');
                                  }
                              )
                          )
                        ],
                      )
                    ],
                  )))),
    );
  }
}
