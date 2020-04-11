import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/authentication/login/bloc/login_bloc.dart';
import 'package:sport_app/authentication/login/widgets/login_form.dart';
import 'package:sport_app/repositories/user_repository.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
      _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository,),
      ),
    );
  }
}