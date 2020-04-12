import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/home/profile/bloc/profile_bloc.dart';
import 'package:fuepitech/home/tab/bloc/tab_bloc.dart';
import 'package:fuepitech/repositories/event_repository.dart';
import 'package:fuepitech/repositories/user_repository.dart';
import 'package:fuepitech/screens/avatar_screen.dart';
import 'package:fuepitech/screens/home_screen.dart';
import 'package:fuepitech/screens/login_screen.dart';
import 'package:fuepitech/screens/splash_screen.dart';

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
            return LoginScreen(userRepository: userRepository);
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
            return const CircularProgressIndicator();
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