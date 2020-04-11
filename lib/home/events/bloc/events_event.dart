part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => <Object>[];
}

class Fetch extends EventsEvent {
  const Fetch({@required this.token});

  final String token;

  @override
  List<Object> get props => <Object>[token];

  @override
  String toString() => 'Fetch {token: $token }';
}