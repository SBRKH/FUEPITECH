import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/models/event.dart';
import 'package:fuepitech/repositories/event_repository.dart';
import 'package:meta/meta.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({ @required this.eventRepository, @required this.auth}) {
    auth.listen((AuthenticationState state) {
      if (state is AuthenticationAuthenticated)
      add(Fetch(token: state.token));
    });
  }

  final EventRepository eventRepository;
  final AuthenticationBloc auth;

  @override
  EventsState get initialState => EventsUninitialized();

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    final EventsState currentState = state;
    if (event is Fetch) {
      try {
        if (currentState is EventsUninitialized) {
          final List<Event> events = await eventRepository.fetchEvents(token: event.token);
          yield EventsLoaded(events: events);
        }
      } catch (_) {
        yield EventError();
      }
    }
  }
}
