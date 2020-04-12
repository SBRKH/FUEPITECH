part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn({
    @required this.token,
    @required this.justRegistered
  });
  final String token;
  final bool  justRegistered;

  @override
  List<Object> get props => <Object>[token, justRegistered];

  @override
  String toString() => 'LoggedIn { token: $token, registered: $justRegistered }';
}

class LoggedOut extends AuthenticationEvent {}