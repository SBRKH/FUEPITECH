part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => <Object>[];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
   const AuthenticationAuthenticated(this.token, this.justRegistered);
  
  final String token;
  final bool  justRegistered;

  @override
  List<Object> get props => <Object>[token];

  @override
  String toString() => 'Authenticated { token: $token, registered: $justRegistered }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}