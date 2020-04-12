import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/models/user.dart';
import 'package:fuepitech/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({@required this.userRepository, @required this.auth}) {
    auth.listen((AuthenticationState state) {
      if (state is AuthenticationAuthenticated) {
        token = state.token;
        add(FetchProfile(token: state.token));
      }
    });
  }

  final UserRepository userRepository;
  final AuthenticationBloc auth;
  String token;

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      if (state is ProfileInitial) {
        try {
          final User user = await userRepository.getUser(token: event.token);
          yield ProfileLoaded(user: user);
        } catch (e) {
          yield ProfileError(error: e);
        }
      }
    } else if (event is UpdateButtonPressed) {
      yield ProfileLoading();
      try {
        await userRepository.updateUser(avatar: event.avatar, firstName: event.firstName, lastName: event.lastName, token: token);
        final User user = await userRepository.getUser(token: token);
        yield ProfileLoaded(user: user);
      } catch (e) {
        yield ProfileError(error: e);
      }
    }
  }
}
