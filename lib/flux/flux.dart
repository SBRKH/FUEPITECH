import 'package:flutter/material.dart';
import '../API/API.dart';
import '../API/Routes.dart';
import './fluxCell.dart';

class FluxView extends StatefulWidget {
  @override
  _FluxViewState createState() => _FluxViewState();
}

class _FluxViewState extends State<FluxView> {
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return FluxCell(data[index]);
          },
        ));
  }

  Future<void> fetchData() async {
    try {
      final dynamic events = await API.get(Routes.GET_EVENTS);

      setState(() {
        data = events['payload']['events'];
      });
    } catch (e) {
      print(e);
    }
  }
}
