import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuepitech/validator/validator.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  Map<String, Object> signupState = {
    'firstName' : null,
    'lastName': null,
    'email': null,
    'password': null,
    'password_check': null,
    'avatar': null
  };

  final formKey = GlobalKey<FormState>();

  void updateState(String key, dynamic value) {
    setState(() {
      signupState[key] = value;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey[200],
        //alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Sign up',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(52, 73, 94, 1)
                  )
              ),
              Container(
                  child: Card(
                    elevation: 5,
                    semanticContainer: true,
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
                                    validator: isEmpty(),
                                    style: const TextStyle(
                                      height: 0.5,
                                    ),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'PRÉNOM',
                                      labelStyle: TextStyle(
                                        
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(53, 59, 72, 1)
                                      )
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    validator: isEmpty(),
                                    style: const TextStyle(
                                      height: 0.5,
                                    ),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Nom',
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    validator: composeValidator([isEmpty(), isEmail()]),
                                    style: const TextStyle(
                                      height: 0.5,
                                    ),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: isEmpty(),
                                    style: const TextStyle(
                                      height: 0.5,
                                    ),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Mot de passe',
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ],
                      )
                  )
                )
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    Scaffold
                        .of(context)
                        .showSnackBar(const SnackBar(content: Text('Processing Data')));
                  }
                },
                child: const Text('Submit'),
              )
          ]
        )
      )
    );
  }
}