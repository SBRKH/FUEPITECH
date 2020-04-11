import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/authentication/register/bloc/register_bloc.dart';
import 'package:sport_app/authentication/register/widgets/avatar_form.dart';
import 'package:sport_app/repositories/user_repository.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({Key key, @required UserRepository userRepository, @required String token})
      : assert(userRepository != null),
      _userRepository = userRepository,
      assert(token != null),
      _token = token,
        super(key: key);

  final UserRepository _userRepository;
  final String _token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choississez votre avatar'),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (BuildContext context) => RegisterBloc(userRepository: _userRepository),
        child: AvatarForm(token: _token),
      ),
    );
  }
}