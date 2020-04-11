import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required this.userRepository,
    @required this.storage})
      : assert(userRepository != null);

  final UserRepository userRepository;
  final FlutterSecureStorage storage;
  
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final Map<String, String> token = await storage.readAll();
      if (token['access_token'] != null) {
        if (token['registered'] == null) {
         yield AuthenticationAuthenticated(token['access_token'], false);
        } else {
          yield AuthenticationAuthenticated(token['access_token'], true);
        }
      } else {
        if (token['access_token'] != null) {
          storage.delete(key: 'access_token');
        }
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      final String token = await storage.read(key: 'access_token');
      if (token == null) {
        storage.write(key: 'access_token', value: event.token);
      }
      if (event.justRegistered == true) {
        storage.write(key: 'registered', value: 'yes');
      } else {
        storage.delete(key: 'registered');
      }
      yield AuthenticationAuthenticated(event.token, event.justRegistered);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await storage.deleteAll();
      yield AuthenticationUnauthenticated();
    }
  }
}
