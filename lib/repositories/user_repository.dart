import 'dart:io';

import 'package:meta/meta.dart';
import 'package:sport_app/models/user.dart';
import 'package:sport_app/repositories/sportsApiclient.dart';

class UserRepository {
  UserRepository({
    @required this.sportApiClient
  }) : assert(sportApiClient != null);

  final SportApiClient sportApiClient;

  Future<String>  login({
    @required String mail,
    @required String password
  }) async {
    return await sportApiClient.login(
      email: mail,
      password: password
      );
  }

  Future<String>  register({
    @required String email, 
    @required String password, 
    @required String firstName, 
    @required String lastName
    }) async {
      return await sportApiClient.register(email: email, password: password,
        firstName: firstName, lastName: lastName);
    }

  Future<void>  addAvatar({
    @required File avatar, @required String token
  }) async => await sportApiClient.addAvatar(avatar: avatar, token: token);

  Future<User>  getUser({
    @required String token
  }) async => await sportApiClient.getUser(token: token);
}