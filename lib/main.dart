import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fuepitech/app.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/home/events/bloc/events_bloc.dart';
import 'package:fuepitech/home/profile/bloc/profile_bloc.dart';
import 'package:fuepitech/repositories/event_repository.dart';
import 'package:fuepitech/repositories/sportsApiclient.dart';
import 'package:fuepitech/repositories/user_repository.dart';
import 'package:fuepitech/widgets/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository(sportApiClient: SportApiClient(httpClient: http.Client()));
  final EventRepository eventRepository = EventRepository(sportApiClient: SportApiClient(httpClient: http.Client()));
  runApp(
    MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) {
            return AuthenticationBloc(userRepository: userRepository, storage: const FlutterSecureStorage())
              ..add(AppStarted());
          }
        ),
        BlocProvider<EventsBloc>(
        create: (BuildContext context) =>
          EventsBloc(eventRepository: eventRepository, auth: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(userRepository: userRepository, auth: BlocProvider.of<AuthenticationBloc>(context),),
        )
      ],
      child: App(userRepository: userRepository, eventRepository: eventRepository,),
    ),
  );
}