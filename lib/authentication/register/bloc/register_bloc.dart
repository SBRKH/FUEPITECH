import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  final UserRepository _userRepository;

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final Stream<RegisterEvent> nonDebounceStream = events.where((RegisterEvent event) {
      return event is! EmailChanged && event is! PasswordChanged;
    });
    final Stream<RegisterEvent>  debounceStream = events.where((RegisterEvent event) {
      return event is EmailChanged || event is PasswordChanged;
    }).debounceTime(const Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith(<Stream<RegisterEvent>>[debounceStream]),
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterWithCredentialsPressedToState(email: event.mail,
                                                    password: event.password,
                                                    firstName: event.firstName,
                                                    lastName: event.lastName);
    } else if (event is AddAvatarButtonPressed) {
      yield* _mapAddAvatar(avatar: event.avatar, token: event.token);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRegisterWithCredentialsPressedToState({
    String email,
    String password,
    String firstName,
    String lastName
  }) async* {
    yield RegisterState.loading();
    try {
      final String token = await _userRepository.register(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        );
      yield RegisterState.success(token);
    } catch (_) {
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapAddAvatar({
    File avatar, String token
  }) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.addAvatar(
        avatar: avatar, token: token
        );
      yield RegisterState.success(token);
    } catch (_) {
      yield RegisterState.failure();
    }
  }

  bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
