import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sport_app/authentication/bloc/authentication_bloc.dart';
import 'package:sport_app/home/events/bloc/events_bloc.dart';
import 'package:sport_app/home/profile/bloc/profile_bloc.dart';
import 'package:sport_app/home/tab/bloc/tab_bloc.dart';
import 'package:sport_app/repositories/event_repository.dart';
import 'package:sport_app/repositories/sportsApiclient.dart';
import 'package:sport_app/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:sport_app/screens/avatar_screen.dart';
import 'package:sport_app/screens/home_screen.dart';
import 'package:sport_app/screens/login_screen.dart';
import 'package:sport_app/screens/splash_screen.dart';
import 'package:sport_app/widgets/loading_indicator.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc<dynamic, dynamic> bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

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

class App extends StatelessWidget {
  const App({Key key, @required this.userRepository, @required this.eventRepository}) : super(key: key);
  
  final UserRepository userRepository;
  final EventRepository eventRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationAuthenticated) {
            if (state.justRegistered == true) {
              return AvatarScreen(userRepository: userRepository, token: state.token);
            } else {
              return MultiBlocProvider(
                providers: <BlocProvider<dynamic>>[
                  BlocProvider<TabBloc>(
                        create: (BuildContext context) =>
                        TabBloc(),
                      ),
                ],
                child: const HomeScreen()
              );
            }
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          if (state is AuthenticationAuthenticated) {
            if (state.justRegistered == true) {
              return AvatarScreen(userRepository: userRepository, token: state.token);
            } else {
              BlocProvider.of<ProfileBloc>(context).add(FetchProfile(token: state.token));
              return MultiBlocProvider(
                providers: <BlocProvider<dynamic>>[
                  BlocProvider<TabBloc>(
                        create: (BuildContext context) =>
                        TabBloc(),
                      ),
                ],
                child: const HomeScreen()
              );
            }
          }
          return Scaffold(appBar: AppBar(title: const Text('error'),), body: const Center(child: Text('There is an error', style: TextStyle(color: Colors.white),)));
        },
      ),
    );
  }
}