import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/authentication/bloc/authentication_bloc.dart';
import 'package:sport_app/models/user.dart';
import 'package:sport_app/repositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({@required this.userRepository, @required this.auth}) {
    auth.listen((AuthenticationState state) {
      if (state is AuthenticationAuthenticated)
      add(FetchProfile(token: state.token));
    });
  }

  final UserRepository userRepository;
  final AuthenticationBloc auth;
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
        } catch (_) {
          yield ProfileError();
        }
      }
    }
  }
}
