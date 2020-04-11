import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/home/profile/bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileError) {
          return Container(child: const Center(child: Text('We can@\'t get your informations'),),);
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            backgroundColor: Colors.grey,
            body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(state.user.avatar),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        onPressed: () {},
                        child: const Icon(Icons.photo_library),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        onPressed: () {},
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: state.user.firstName,
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0)
                          )
                        ),
                        autocorrect: false,
                        autovalidate: true,
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: state.user.lastName,
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0)
                          )
                        ),
                        autocorrect: false,
                        autovalidate: true,
                      ),
                      const SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ),
                    ],
                  ),
                  )
              ],
            ),
          ),
        ),
          );
        }
        return Container(child: const Center(child: Text('Error to get your informations'),),);
      }
    );
  }
}