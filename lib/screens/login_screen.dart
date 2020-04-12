import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/authentication/login/bloc/login_bloc.dart';
import 'package:fuepitech/authentication/login/widgets/login_form.dart';
import 'package:fuepitech/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
      _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.yellow[600],
      ),
      body: BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository,),
      ),
    );
  }
}