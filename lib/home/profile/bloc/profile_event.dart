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