import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/home/events/bloc/events_bloc.dart';
import 'package:fuepitech/home/events/widgets/event_widget.dart';
import 'package:fuepitech/screens/details_screen.dart';


class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (BuildContext context, EventsState state) {
        if (state is EventsUninitialized) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EventError) {
          return const Center(
            child: Text('Erreur: impossible de récupérer les events'),
          );
        }
        if (state is EventsLoaded) {
          if (state.events.isEmpty) {
            return const Center(
              child: Text('Il n\'a pas d\'events pres de chez vous'),
            );
          }
          return Container(
            height:MediaQuery.of(context).size.height,
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 300,
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: EventWidget(
                  event: state.events[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<EventsBloc>(builder: (BuildContext context) {
                        return DetailsScreen(id: state.events[index].id);
                      }),
                    );
                  },
                )
              );
            },
            itemCount:state.events.length
          )
          );
        }
        return const Center(child: Text('Y a un probleme captain'),);
      },
    );
  }
}