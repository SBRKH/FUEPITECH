import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/home/events/bloc/events_bloc.dart';
import 'package:sport_app/models/event.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    @required this.id,
  Key key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<EventsBloc, EventsState>(
      builder: (BuildContext context, EventsState state) {
        final Event event = (state as EventsLoaded)
            .events
            .firstWhere((Event event) => event.id == id, orElse: () => null);
        return Scaffold(
          body: event == null
              ? Container(child: const Center(child: Text('Error Loading Event'),),)
              : Scaffold(
                appBar: AppBar(
                  title: Text(event.title),
                ),
                body: ListView(
                children: <Widget>[
                  Image.network(event.photoCover, width: 600, height: 240, fit: BoxFit.cover,),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(event.title, 
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                              ),
                              Text(event.city, 
                                style: TextStyle(color: Colors.grey,),
                              ),
                              Text('Date: ${event.date}'),
                            ],
                          ),
                        ),
                        Icon(Icons.people, size: 50,),
                        Text('${event.participants}'),
                      ],
                    ),
                  ),
                ],
              )
              )
        );
      },
    );
  }
}