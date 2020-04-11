import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sport_app/api/api.dart';
import 'package:sport_app/models/event.dart';
import 'package:sport_app/models/user.dart';


class SportApiClient {
  SportApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  final http.Client httpClient;

  Future<void>  addAvatar({File avatar, String token}) async {
    final http.MultipartRequest request = http.MultipartRequest('PUT', Uri.parse(SportsApi.user));
    request.fields['name'] = 'avatar.png';
    request.fields['type'] = 'image/png';
    http.MultipartFile(
      avatar.toString().split('/').last,
      avatar.readAsBytes().asStream(),
      avatar.lengthSync(),
      filename: avatar.toString().split('/').last
    );
    debugPrint('TOKEN: $token ; filename: ${avatar.toString().split('/').last} ; ');
    request.headers.addAll(<String, String>{
      'Authorization' : 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    });
    final http.StreamedResponse response = await request.send();
    debugPrint('errroor: ${request.headers}');
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String>  register({String email, String password, 
    String firstName, String lastName}) async {
      try {
        final http.Response sign = await httpClient.post(SportsApi.signup, 
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(<String, dynamic>{
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'password': password,
            'gender': 'male',
            'birthday': '0000-00-00',
            'address': 'Epitech',
            'country': 'France',
            'city': 'Paris',
            'disciplines': json.encode(<String, dynamic>{'disciplines': <int>[1, 2]}),
          })
        );
        if (sign.statusCode == 400) {
          debugPrint('error:: ${sign.body.toString()}');
        }
        if (sign.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(sign.body)['payload'] as Map<String, dynamic>;
          return data['access_token'];
        } else {
          throw Exception(sign.reasonPhrase);
        }
      } catch (e) {
        rethrow;
      }
  }

  Future<String>  login({String email, String password}) async {
    try {
      final http.Response log = await http.post(SportsApi.login, 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'email': email,
          'password': password
          }
        )
      );
      if (log.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(log.body)['payload'] as Map<String, dynamic>;
        return data['access_token'];
      }
      else {
        throw Exception(log.reasonPhrase);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Event>> fetchEvents({String token}) async {
    final http.Response response = await httpClient.get(
        'https://api.sportsnconnect.com/activity/events?page=1',
        headers: <String, String>{
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      final Map<String, Object> data = json.decode(response.body)['payload'] as Map<String, Object>;
      final List<dynamic> dList = List<dynamic>.from(data['events']);
      return dList.map<Event>((Object json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('error fetching events');
    }
  }

  Future<User>  getUser({String token}) async {
    final http.Response response = await httpClient.get(
        SportsApi.user,
        headers: <String, String>{
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['user'] as Map<String, dynamic>;
      return User.fromJson(data);
    } else {
      throw Exception('error fetching your profile');
    }
  }
}