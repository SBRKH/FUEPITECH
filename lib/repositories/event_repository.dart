import 'package:fuepitech/models/event.dart';
import 'package:fuepitech/repositories/sportsApiclient.dart';
import 'package:meta/meta.dart';


class EventRepository {
  EventRepository({
    @required this.sportApiClient
  }) : assert(sportApiClient != null);

  final SportApiClient sportApiClient;

  Future<List<Event>> fetchEvents({String token}) async {
    return await sportApiClient.fetchEvents(token: token);
  }
}