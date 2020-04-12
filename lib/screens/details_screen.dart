import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/home/events/bloc/events_bloc.dart';
import 'package:fuepitech/models/event.dart';


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
            debugPrint('disciplines: ${event.disciplines.length}');
        return Scaffold(
          body: event == null
              ? Container(child: const Center(child: Text('Error Loading Event'),),)
              : Scaffold(
                appBar: AppBar(
                  title: Text(event.title),
                  backgroundColor: Colors.yellow[600],
                ),
                body: ListView(
                children: <Widget>[
                  Image.network(event.photoCover, width: 600, height: 240, fit: BoxFit.cover,),
                  Container(
                    child: event.disciplines.length > 1 ?
                    ListView.builder(
                      itemCount: event.disciplines.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Chip(backgroundColor: Colors.yellow[300], label: Text(event.disciplines[index]));
                      }
                    ) : Chip(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      backgroundColor: Colors.yellow[300], 
                      label: Text(event.disciplines[0]),
                    ),
                  ),
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
                                style: TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                              Text('Date: ${event.date}', style: const TextStyle(fontSize: 15),),
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