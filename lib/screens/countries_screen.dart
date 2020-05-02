import 'package:covid19tracker/networking/networking.dart';
import 'package:covid19tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: same screen for all countries and continents
// TODO: Search
// TODO: filter

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List countriesData;
  final formatter = new NumberFormat("#,###");
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  fetchCountriesData() async {
    try {
      dynamic data = await NetworkHelper().getCountriesStats();
      if (mounted){
        setState(() {
          countriesData = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    fetchCountriesData();
    return null;
  }

  @override
  void initState() {
    super.initState();
    fetchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COUNTRIES STATS'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        child: countriesData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: countriesData == null ? 0 : countriesData.length,
                    itemBuilder: (context, index) {
                      var country = countriesData[index]['country'];
                      var flag = countriesData[index]['countryInfo']['flag'];
                      var active = countriesData[index]['active'];
                      var todayCases = countriesData[index]['todayCases'];
                      return Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[100],
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(flag),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 150,
                                              child: Text(
                                                country,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: kFontSize20,
                                                ),
                                              ),
                                            ),
                                            todayCases > 0
                                                ? Text(
                                                    '+ ' + formatter.format(todayCases),
                                                    style: TextStyle(
                                                      fontSize: kFontSize15,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : Text(
                                                    formatter.format(todayCases),
                                                    style: TextStyle(
                                                      fontSize: kFontSize15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          formatter.format(active),
                                          style: TextStyle(
                                            fontSize: kFontSize25,
                                            color: kActiveColor,
                                          ),
                                        ),
                                        Text(
                                          'active',
                                          style: TextStyle(
                                            fontSize: kFontSize15,
                                            color: kTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
