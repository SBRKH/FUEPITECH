import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/home/profile/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  File _newImage;
  ProfileBloc _profileBloc;
  dynamic _pickImageError;

  bool get isPopulated {
     return _lastNameController.text.isNotEmpty || _firstNameController.text.isNotEmpty || (_newImage != null);
  }

  bool isUpdateButtonEnabled() {
    return isPopulated;
  }

  Future<void> _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      _newImage = await ImagePicker.pickImage(source: source);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileInitial || state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileError) {
          return Container(child: const Center(child: Text('We can@\'t get your informations'),),);
        }
        if (state is ProfileLoaded) {
          return SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height,
          child:Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                   CircleAvatar(
                  radius: 80,
                  backgroundImage: (_pickImageError != null) ? null : (_newImage == null) ? NetworkImage(state.user.avatar) : FileImage(_newImage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          _onImageButtonPressed(ImageSource.gallery, context: context);
                        },
                        child: const Icon(Icons.photo_library),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          _onImageButtonPressed(ImageSource.camera, context: context);
                        },
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'First Name',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                hintText: state.user.firstName,
                                border: InputBorder.none,
                                fillColor: const Color(0xfff3f3f4),
                                filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Last Name',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                hintText: state.user.lastName,
                                border: InputBorder.none,
                                fillColor: const Color(0xfff3f3f4),
                                filled: true))
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        onPressed:  isUpdateButtonEnabled() ? _onSubmitButton : null,
                        textColor: Colors.white,
                        color: Colors.yellow[700],
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
          );
        }
        return Container(child: const Center(child: Text('Error to get your informations'),),);
      }
    );
  }

  void _onSubmitButton() {
    _profileBloc.add(
      UpdateButtonPressed(
        avatar: _newImage,
        firstName:  _firstNameController.text,
        lastName: _lastNameController.text,
      ),
    );
  }
}