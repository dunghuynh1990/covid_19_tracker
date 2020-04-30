import 'package:covid19tracker/services/networking.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void getData() async {
    try {
      dynamic data = await NetworkHelper().getAll();
      print(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('COVID TRACKER'),
      ),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}