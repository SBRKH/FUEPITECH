import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/home/tab/bloc/tab_bloc.dart';
import 'package:fuepitech/home/tab/widgets/tab_selector.dart';
import 'package:fuepitech/models/app_tab.dart';
import 'package:fuepitech/screens/events_screen.dart';
import 'package:fuepitech/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (BuildContext context, AppTab state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SPORTS EVENT'),
            backgroundColor: Colors.yellow[600],
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
              )
            ],
          ),
          body: state == AppTab.events ? const EventsScreen() : ProfileScreen(),
          bottomNavigationBar: TabSelector(
            activeTab: state,
            onTabSelected: (AppTab tab) => BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      }
    );
  }
}