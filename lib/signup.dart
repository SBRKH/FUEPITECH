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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey[200],
        //alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(-50.0, -100.0, 0.0),
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(142, 129, 244, 1)
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(196, 103, 230, 1)
                    ),
                  ),
                ],
              ),
              const Text('Inscription',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(52, 73, 94, 1)
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 10.0),
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
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'NOM',
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
                                    validator: composeValidator([isEmpty(), isEmail()]),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'EMAIL',
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
                                    obscureText: true,
                                    validator: isEmpty(),
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'MOT DE PASSE',
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
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: isEmpty(),
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'RETAPER MOT DE PASSE',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(53, 59, 72, 1)
                                        )
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
              Center(
                child: Column(
                  children: <Widget>[
                    const Text('S\'inscrire',
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                            color: Color.fromRGBO(52, 73, 94, 0.6)
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            Scaffold
                                .of(context)
                                .showSnackBar(const SnackBar(content: Text('Processing Data')));
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                        ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel: 'Suivant',
                        ),
                      )
                    )
                  ],
                ),
              )
          ]
        )
      )
    );
  }
}