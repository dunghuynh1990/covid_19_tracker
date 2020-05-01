import 'package:covid19tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'info_cards.dart';

class DataCards extends StatelessWidget {
  DataCards({
    @required this.continent,
    @required this.active,
    @required this.deaths,
    @required this.recovered,
  });

  final String continent;
  final int active;
  final int deaths;
  final int recovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      width: 280.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              continent,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
          Divider(
            color: Colors.black54,
            thickness: 2.0,
            indent: 8.0,
          ),
          InfoCards(
            title: 'Active Cases',
            data: active,
            textSize: kFontSize20,
            cardColor: kActiveColor,
          ),
          InfoCards(
            title: 'Deaths',
            data: deaths,
            textSize: kFontSize20,
            cardColor: kDeathColor,
          ),
          InfoCards(
            title: 'Recovered',
            data: recovered,
            textSize: kFontSize20,
            cardColor: kRecoveredColor,
          ),
        ],
      ),
    );
  }
}
