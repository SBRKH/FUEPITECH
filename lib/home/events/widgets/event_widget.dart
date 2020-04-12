import 'package:flutter/material.dart';
import 'package:fuepitech/models/event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({Key key, @required this.event, @required this.onTap,}) : super(key: key);

  final Event event;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(event.photoCover)
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Chip(
            backgroundColor: Colors.yellow[100],
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            label: Text(event.title, 
              style: TextStyle(fontSize: 22, 
                fontWeight: FontWeight.bold), 
                textAlign: TextAlign.center,
            )
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}