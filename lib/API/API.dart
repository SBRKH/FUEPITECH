class SportsApi {
  static const String url = 'https://api.sportsnconnect.com/';
  static const String login = '${url}auth/login';
  static const String signup = '${url}auth/register';
  static const String user = '${url}users/me';

  static String getEvents(int page) {
    return '${url}activity/events?page=$page';
  }
}