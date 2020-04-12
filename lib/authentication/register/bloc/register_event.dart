part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  const RegisterButtonPressed({
    @required this.mail,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });
  
  final String mail;
  final String password;
  final String firstName;
  final String lastName;

  @override
  List<Object> get props => <Object>[mail, password, firstName, lastName];

  @override
  String toString() =>
      'RegisterButtonPressed { mail: $mail, password: $password, firstName: $firstName, lastName: $lastName }';
}

class AddAvatarButtonPressed extends RegisterEvent {
  const AddAvatarButtonPressed({@required this.avatar, @required this.token});

  final File avatar;
  final String token;

  @override
  List<Object> get props => <Object>[avatar];

  @override
  String toString() => 'AddAvatarButtonPressed { avatar: ${avatar.toString()}, token: $token }';
}


class EmailChanged extends RegisterEvent {
  const EmailChanged({@required this.email});

  final String email;

  @override
  List<Object> get props => <Object>[email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class FirstNameChanged extends RegisterEvent {
  const FirstNameChanged({@required this.firstName});

  final String firstName;

  @override
  List<Object> get props => <Object>[firstName];

  @override
  String toString() => 'FirstNameChanged { email :$firstName }';
}

class LastNameChanged extends RegisterEvent {
  const LastNameChanged({@required this.lastName});

  final String lastName;

  @override
  List<Object> get props => <Object>[lastName];

  @override
  String toString() => 'LastNameChanged { email :$lastName }';
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({@required this.password});

  final String password;

  @override
  List<Object> get props => <Object>[password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}