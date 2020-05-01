import 'package:covid19tracker/models/world_wide_model.dart';
import 'package:covid19tracker/networking/networking.dart';
import 'package:covid19tracker/utilities/constants.dart';
import 'package:covid19tracker/widgets/data_cards.dart';
import 'package:covid19tracker/widgets/info_cards.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String updatedDate = '';
  int active = 0;
  int deaths = 0;
  int recovered = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void getData() async {
    try {
      dynamic data = await NetworkHelper().getAll();
      print(data);
      var date = DateTime.fromMillisecondsSinceEpoch(data['updated']);
      setState(() {
        updatedDate = DateFormat.yMMMMd().add_jms().format(date);
        active = data['active'];
        deaths = data['deaths'];
        recovered = data['recovered'];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    try {
      dynamic data = await NetworkHelper().getAll();
      print(data);
      var date = DateTime.fromMillisecondsSinceEpoch(data['updated']);
      setState(() {
        updatedDate = DateFormat.yMMMMd().add_jms().format(date);
        active = data['active'];
        deaths = data['deaths'];
        recovered = data['recovered'];
      });
    } catch (e) {
      print(e);
    }
    return null;
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
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child:
        updatedDate.length == 0
            ? SpinKitDoubleBounce(
          color: Colors.grey,
          size: 100.0,
        )
            : SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 20,
                    ),
                    Text(
                      ' $updatedDate',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'World Wide',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black54,
                    ),
                  ),
                ),
                InfoCards(title: 'Active Cases', data: active, textSize: kFontSize30, cardColor: kActiveColor),
                InfoCards(
                  title: 'Deaths',
                  data: deaths,
                  textSize: kFontSize30,
                  cardColor: kDeathColor,
                ),
                InfoCards(
                  title: 'Recovered',
                  data: recovered,
                  textSize: kFontSize30,
                  cardColor: kRecoveredColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Continents',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 350.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                      DataCards(continent: 'World Wide', active: active, deaths: deaths, recovered: recovered),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

