import 'dart:io';

import 'package:fuepitech/models/user.dart';
import 'package:fuepitech/repositories/sportsApiclient.dart';
import 'package:meta/meta.dart';


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

  Future<void>  updateUser({
    File avatar, String firstName, String lastName, String token
  }) async => await sportApiClient.updateUser(avatar: avatar,
    firstName: firstName, lastName: lastName, token: token);
}