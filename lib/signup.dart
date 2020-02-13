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
        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
        color: Colors.grey[200],
        //alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
              ),
              Text('Sign Up',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.black)),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: isEmpty(),
                          style: const TextStyle(
                            height: 0.5,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Prénom',
                          ),
                        ),
                        TextFormField(
                          validator: isEmpty(),
                          style: const TextStyle(
                            height: 0.5,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nom',
                          ),
                        ),
                        TextFormField(
                          validator: composeValidator([isEmpty(), isEmail()]),
                          style: const TextStyle(
                            height: 0.5,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: isEmpty(),
                          style: const TextStyle(
                            height: 0.5,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe',
                          ),
                        ),
                      RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            Scaffold
                                .of(context)
                                .showSnackBar(const SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: const Text('Submit'),
                      )
                      ],
                    )
                  )
                )
              )
          ]
        )
      )
    );
  }
}