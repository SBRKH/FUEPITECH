import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuepitech/validator/validator.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  Map<String, Object> signupState = {
    'firstName': null,
    'lastName': null,
    'email': null,
    'password': null,
    'password_check': null,
    'avatar': null
  };

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updateState(String key, dynamic value) {
    setState(() {
      signupState[key] = value;
    });
  }

  Future<void> handleTapAvatar() async {
    final File file = await ImagePicker.pickImage(source: ImageSource.camera);
    updateState('avatar', file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
         child: Container(
            color: const Color.fromRGBO(247, 246, 249, 1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(-60.0, -120.0, 0.0),
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(142, 129, 244, 1)),
                  ),
                  Container(
                    transform: Matrix4.translationValues(60.0, -100.0, 0.0),
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(235, 53, 117, 1)),
                  ),
                  Container(
                    transform: Matrix4.translationValues(-125.0, -80.0, 0.0),
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(246, 199, 83, 0.9)),
                  ),
                  Container(
                    transform: Matrix4.translationValues(-350.0, -150.0, 0.0),
                    width: 160,
                    height: 160,
                    child: CustomPaint(
                      size: const Size(160, 160),
                      painter: CustomArcCircle(
                          const Color.fromRGBO(196, 103, 230, 1)),
                    ),
                  ),
                ],
              ),
              Container(
                  transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Inscription',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromRGBO(52, 73, 94, 1)))),
              Container(
                  transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 10.0, right: 10.0),
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
                                    GestureDetector(
                                      onTap: handleTapAvatar,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: CircleAvatar(
                                          radius: 40.0,
                                          backgroundColor: Colors.yellow,
                                          child: Text('AVATAR'),
                                        )
                                      ),
                                    )
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: TextFormField(
                                        validator: isEmpty(),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'PRÉNOM',
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    129, 137, 142, 1))),
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: TextFormField(
                                        validator: isEmpty(),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'NOM',
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    129, 137, 142, 1))),
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: TextFormField(
                                        validator: composeValidator(
                                            [isEmpty(), isEmail()]),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'EMAIL',
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    129, 137, 142, 1))),
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: isEmpty(),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'MOT DE PASSE',
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    129, 137, 142, 1))),
                                      ),
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: isEmpty(),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'RETAPER MOT DE PASSE',
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    129, 137, 142, 1))),
                                      ),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      padding: const EdgeInsets.only(
                                          top: 30.0, bottom: 30.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed("loginView");
                                          },
                                          child: const Text(
                                            'j\'ai déjà un compte, me connecter',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    198, 197, 203, 1)),
                                          )))
                                ],
                              ),
                            ],
                          )))),
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                      child: const Text('S\'inscrire',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Color.fromRGBO(52, 73, 94, 0.6)))),
                    Container(
                        transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                        padding: const EdgeInsets.only(top: 15.0),
                        child: RaisedButton(
                          color: const Color.fromRGBO(128, 99, 246, 1),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              Scaffold.of(context).showSnackBar(const SnackBar(
                                  content: Text('Processing Data')));
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel: 'Suivant',
                          ),
                        ))
                  ],
                ),
              )
            ]))));
  }
}

class CustomArcCircle extends CustomPainter {
  CustomArcCircle(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const Rect rect = Rect.fromLTRB(50, 50, 175, 170);
    final double startAngle = 360 * math.pi;
    final double sweepAngle = math.pi;
    const bool useCenter = false;
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
