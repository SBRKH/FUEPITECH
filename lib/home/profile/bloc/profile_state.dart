part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => <Object>[];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  const ProfileError({this.error});

  final dynamic error;

  @override
  List<Object> get props => <Object>[error];

  @override
  String toString() => 'ProfileError {error: $error';
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({this.user});

  final User user;

  @override
  List<Object> get props => <Object>[];
}