import 'package:flutter/material.dart';
import 'package:sport_app/models/event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({Key key, @required this.event, @required this.onTap,}) : super(key: key);

  final Event event;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(event.photoCover, fit: BoxFit.cover,),
      title: Text(event.title),
      isThreeLine: true,
      subtitle: Text(event.city),
      dense: true,
      onTap: onTap,
    );
  }
}