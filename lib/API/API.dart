import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class API {
  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final HttpClient httpClient = HttpClient();
    final HttpClientRequest request = await httpClient.postUrl(Uri.parse('https://api.sportsnconnect.com/auth/login'));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    final HttpClientResponse response = await request.close();
    final String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    return json.decode(reply);
  }
}