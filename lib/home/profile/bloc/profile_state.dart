part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => <Object>[];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {}


class ProfileLoaded extends ProfileState {
  const ProfileLoaded({this.user});

  final User user;

  @override
  List<Object> get props => <Object>[];
}