import 'package:flutter/material.dart';
import 'package:fuepitech/repositories/user_repository.dart';
import 'package:fuepitech/screens/register_screen.dart';


class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(builder: (BuildContext context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}