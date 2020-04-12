import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuepitech/authentication/bloc/authentication_bloc.dart';
import 'package:fuepitech/authentication/register/bloc/register_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AvatarForm extends StatefulWidget {
  const AvatarForm({Key key, @required String token}) : 
    assert(token != null),
        _token = token,
        super(key: key);

  final String _token;

  @override
  _AvatarFormState createState() => _AvatarFormState();
}

class _AvatarFormState extends State<AvatarForm> {
  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  RegisterBloc _registerBloc;

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  String get _token {
    return widget._token;
  }

  Future<void> _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(_imageFile, height: MediaQuery.of(context).size.height / 3, width: MediaQuery.of(context).size.width / 3,);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(10),
        child: const Center(
          child: Text(
            'Vous n\'avez pas choisi d\'avatar pour le moment',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Loggin in...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn(token: state.token, justRegistered: false));
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Platform.isAndroid
                    ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container(
                                margin: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Vous n\'avez pas choisi d\'avatar pour le moment',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                          case ConnectionState.done:
                            return _previewImage();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Vous n\'avez pas choisi d\'avatar pour le moment',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                        }
                      },
                    )
                  : _previewImage(),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: RaisedButton(
              onPressed: (_imageFile == null) ? () {} : _onSubmitButton,
              child: const Icon(Icons.fast_forward),
            ),
          ),

        ],
      ),
    );
  }
      )
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
  
  void _onSubmitButton() {
    _registerBloc.add(
      AddAvatarButtonPressed(
        avatar: _imageFile,
        token: _token,
      ),
    );
  }
}