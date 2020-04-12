import 'package:equatable/equatable.dart';

class Event extends Equatable{
  const Event(this.id, this.title, this.city, this.photoCover, this.date, this.participants, this.disciplines);

  final int     id;
  final String  title;
  final String  city;
  final String  photoCover;
  final String  date;
  final int     participants;
  final List<String> disciplines;

  @override
  List<Object>  get props => <Object>[id, title, city, photoCover, date, participants, disciplines];

  @override
  String toString() {
    return 'Event{id: $id, title: $title, city: $city, date: $date}';
  }

  static Event fromJson(Map<String, dynamic> json) {
    final List<String> disciplines = List<String>.from(json['disciplines']);
    return Event(
      json['id'] as int,
      json['title'] as String,
      json['city'] as String,
      json['photo_cover'] as String,
      json['from'] as String,
      json['interestedPeopleCount'] as int,
      disciplines,
    );
  }  
}