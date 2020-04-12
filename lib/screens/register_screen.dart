import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/authentication/register/bloc/register_bloc.dart';
import 'package:fuepitech/authentication/register/widgets/register_form.dart';
import 'package:fuepitech/repositories/user_repository.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.yellow[600],),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}