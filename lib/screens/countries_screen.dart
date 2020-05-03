import 'package:covid19tracker/networking/networking.dart';
import 'package:covid19tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: same screen for all countries and continents
// TODO: Instant Search
// TODO: handle search fail
// TODO: FutureBuilder

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List countriesData = [], searchList = [];
  final formatter = new NumberFormat("#,###");
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Icon _searchIcon = Icon(Icons.search);
  FocusNode _focusNode = new FocusNode();
  List filteredNames; // names filtered by search text
  Widget _appBarTitle = Text('COUNTRIES STATS');
  final myController = TextEditingController();

  void choiceAction(String choice) {
    if (choice == kToday) {
      setState(() {
        countriesData.sort((b, a) => a['todayCases'].compareTo(b['todayCases']));
      });
    } else if (choice == kActive) {
      setState(() {
        countriesData.sort((b, a) => a['active'].compareTo(b['active']));
      });
    } else if (choice == kTotal) {
      setState(() {
        countriesData.sort((b, a) => a['cases'].compareTo(b['cases']));
      });
    }
  }

  void fetchCountriesData() async {
    try {
      dynamic data = await NetworkHelper().getCountriesStats();
      if (mounted) {
        setState(() {
          countriesData = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void searchCountry(String country) async {
//    List tempData = countriesData;
    setState(() {
      countriesData.clear();
    });
    try {
      dynamic data = await NetworkHelper().getCountryStats(country);
      print(data);
      if (data) {
        setState(() {
          countriesData.add(data);
        });
      } else {

      }
    } catch (e) {
      print(e);
      AlertDialog(
        title: new Text("Alert Dialog title"),
        content: new Text("Alert Dialog body"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    fetchCountriesData();
    return null;
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      print(query);
      List _searchList = [];
      searchList = countriesData.where((item) => item['country'] == "Viet").toList();
    } else {
      setState(() {});
    }
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _appBarTitle = Container(
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            controller: myController,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            keyboardAppearance: Brightness.light,
            autofocus: true,
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white,
              fontSize: kFontSize20,
              fontWeight: FontWeight.w300,
            ),
            decoration: new InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintText: 'Search countries...',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: kFontSize20,
                fontWeight: FontWeight.w300,
              ),
            ),
            onChanged: (value) {
//              filterSearchResults(value);
            },
            onEditingComplete: () {
              searchCountry(myController.text);
              _focusNode.unfocus();
            },
          ),
        );
      } else {
        myController.clear();
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text('COUNTRIES STATS');
//        filteredNames = names;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountriesData();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _searchPressed();
            },
            icon: _searchIcon,
          ),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return kChoices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: countriesData.length == 0
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
                      var total = countriesData[index]['cases'];
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 80,
//                        padding: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          color: Colors.white,
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey[100],
//                              blurRadius: 10,
//                              offset: Offset(0, 10),
//                            ),
//                          ],
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
                                              width: 140,
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
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          formatter.format(active),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
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
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          formatter.format(total),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: kActiveColor,
                                          ),
                                        ),
                                        Text(
                                          'total',
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
