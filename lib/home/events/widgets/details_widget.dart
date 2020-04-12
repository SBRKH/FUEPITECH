import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/home/events/bloc/events_bloc.dart';
import 'package:fuepitech/models/event.dart';


class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    @required this.id,
  Key key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<EventsBloc, EventsState>(
      builder: (BuildContext context, EventsState state) {
        if (state is EventsLoaded) {
          final Event event = state
              .events
              .firstWhere((Event event) => event.id == id, orElse: () => null);
          return Scaffold(
            appBar: AppBar(
              title: Text(event.title),
            ),
            body: event == null
              ? Container(child: const Center(child: Text('Error Loading Event'),),)
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Image.network(event.photoCover),
                    Text('title: ${event.title}'),
                    Text('City: ${event.city}'),
                    Text('Participants: ${event.participants}'),
                    Text('date: ${event.date}'),
                  ],
                )
              ),
          );
        } else {
          return Container(child: const Center(child: Text('Error Loading Event'),));
        }  
      }
    );
  }
}