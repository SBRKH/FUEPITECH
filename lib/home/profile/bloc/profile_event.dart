part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

class FetchProfile extends ProfileEvent {
  const FetchProfile({@required this.token});

  final String token;

  @override
  String toString() => 'Fetch {token: $token}';
}

class UpdateButtonPressed extends ProfileEvent {
  const UpdateButtonPressed({@required this.avatar, 
    @required this.firstName, @required this.lastName});

  final File avatar;
  final String firstName;
  final String lastName;
  
  @override
  List<Object> get props => <Object>[avatar, firstName, lastName];

  @override
  String toString() => 'UpdateButtonPressed {avatar: ${avatar.toString()}, firstName: $firstName, lastName: $lastName';
}