part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => <Object>[];
}

class EventsUninitialized extends EventsState {}

class EventError extends EventsState {}

class EventsLoaded extends EventsState {
  const EventsLoaded({
    this.events,
  });

  final List<Event> events;

  EventsLoaded copyWith({
    List<Event> evs,
    bool hasReachedMax,
  }) {
    return EventsLoaded(
      events: evs ?? events,
    );
  }

  @override
  List<Object> get props => <Object>[events];

  @override
  String toString() =>
      'EventsLoaded { events: ${events.length}';
}

class EventLoaded extends EventsState {
  const EventLoaded({
    this.event,
  });

  final Event event;

  EventLoaded copyWith({
    Event ev,
    bool hasReachedMax,
  }) {
    return EventLoaded(
      event: ev ?? event,
    );
  }

  @override
  List<Object> get props => <Object>[event];

  @override
  String toString() =>
      'EventLoaded { event: ${event.title}';
}