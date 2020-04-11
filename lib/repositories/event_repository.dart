import 'package:meta/meta.dart';
import 'package:sport_app/models/event.dart';
import 'package:sport_app/repositories/sportsApiclient.dart';

class EventRepository {
  EventRepository({
    @required this.sportApiClient
  }) : assert(sportApiClient != null);

  final SportApiClient sportApiClient;

  Future<List<Event>> fetchEvents({String token}) async {
    return await sportApiClient.fetchEvents(token: token);
  }
}